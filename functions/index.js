/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");
const admin=require("firebase-admin");
const auth=require("firebase-auth");

var serviceAccount = require("./health10293-firebase-adminsdk-wlljd-7fe8dc5cc8.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.createCustomToken = functions.region("asia-northeast3").https.onRequest(async (request, response) => {
  const user = request.body;

  const uid = user.uid;
  const updateParams = {
    photoURL: user.photoURL,
    displayName: user.displayName,
  };

  if (user.email) {
    updateParams.email = user.email;
  }

  try {
    await admin.auth().updateUser(uid, updateParams);
  } catch (e) {
    updateParams["uid"] = uid;
    if (user.email) {
      updateParams.email = user.email;
    }
    await admin.auth().createUser(updateParams);
  }

  const token = await admin.auth().createCustomToken(uid);
  response.send(token);
});

exports.sendCommentNotification = functions.region("asia-northeast3").firestore
  .document("User_Posts/{postId}/Comments/{commentId}")
  .onCreate(async (snapshot, context) => {
    // 댓글 정보 조회
    const comment = snapshot.data();

    // 댓글 작성자와 게시물 작성자가 같으면 알림을 보내지 않습니다
    if (comment.CommentedBy === comment.PostAuthor) {
      return;
    }

    if (!comment.PostAuthor) {
      console.error(comment);
      console.error("게시물 작성자의 UID가 없습니다.");
      return;
    }

    // 게시물 작성자의 FCM 토큰 조회
    const postAuthorRef = await admin
      .firestore()
      .collection("users")
      .doc(comment.PostAuthor)
      .get();

    const postAuthorData = postAuthorRef.data();
    if (!postAuthorData || !postAuthorData.fcmToken) {
      console.error(`FCM 토큰이 없거나 유효하지 않습니다.`);
      return;
    }
    const fcmToken = postAuthorData.fcmToken;

    // 알림 메시지 구성
    const payload = {
      notification: {
        title: "새로운 댓글",
        body: `${comment.CommentedBy.split('@')[0]}님이 댓글을 남겼습니다: ${comment.CommentText}`,
      },
    };

    // 알림 메시지 전송
    return admin.messaging().sendToDevice(fcmToken, payload);
});