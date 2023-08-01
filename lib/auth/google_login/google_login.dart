import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/auth/google_login/google_social_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleLogin implements google_SocialLogin {
  User? firebaseUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User?> login() async {
    // 반환 값을 User? 타입으로 변경
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          print("Google 로그인 성공: $user");
          /*await uploadGoogleUserInfoToFirestore(user);*/
          firebaseUser = user;
          return user; // User 객체 반환
        } else {
          print("Google 로그인 실패");
          return null; // 로그인 실패시 null 반환
        }
      }
    } catch (e) {
      print(e);
      return null; // 예외 발생 시 null 반환
    }

    return null; // 사용자가 로그인하지 않은 경우 반환
  }

  @override
  Future<bool> logout() async {
    await _googleSignIn.signOut();
    firebaseUser = null; // 로그아웃 시 firebaseUser를 null로 설정
    return true;
  }

  /*Future<void> uploadGoogleUserInfoToFirestore(User? user) async {
    // 사용자 정보를 Firestore의 'users' 컬렉션에 추가합니다.
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(user?.email).set({
        'displayName': user?.displayName,
        'email': user?.email,
        'photoURL': user?.photoURL,
      });
    } catch (e) {
      print('Error adding Google user to Firestore: $e');
    }
  }*/
}
