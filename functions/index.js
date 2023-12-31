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
    const postId = context.params.postId;
    const commentId = context.params.commentId;

    // 댓글 정보 조회
    const comment = snapshot.data();

    // 해당 게시물에 이전에 댓글을 작성한 사용자들의 UID 목록을 생성
     const previousCommentsSnapshot=await admin.firestore().collection('User_Posts').doc(postId).collection('Comments').get();

     let commentUidsSet=new Set([comment.PostAuthor]);

     previousCommentsSnapshot.forEach(docSnapshot=>{
         let previousComment=docSnapshot.data();
         if(previousComment.CommentedBy !== comment.CommentedBy){
             commentUidsSet.add(previousComment.CommentedBy);
         }
     });

     // 공지 대상자 목록 조회 및 알림 설정 확인
     let fcmTokens=new Set();

     for(let uid of commentUidsSet){
         let userDoc=await admin.firestore().collection('users').doc(uid).get();
         let userData=userDoc.data();

         if(userData.notification && userData.fcmToken){
             fcmTokens.add(userData.fcmToken);
         }
     }

   // 알림 메시지 구성
   const payload={
       notification:{
           title: "새로운 댓글",
           body: `${comment.CommentedBy.split('@')[0]}님이 댓글을 남겼습니다: ${comment.CommentText}`,
       },
       data: {
          postId: postId,
          commentId: commentId,
        },
   };

   // 알림 메시지 전송
   return admin.messaging().sendToDevice(Array.from(fcmTokens), payload);

});
