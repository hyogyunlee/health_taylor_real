import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/auth/login_page.dart';
import 'package:health_taylor/pages/All_Pages.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  kakao.KakaoSdk.init(nativeAppKey: 'a142c3efae28bc1a3df7e1b83e833b3f');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await saveUserFcmToken();
  runApp(const MyApp());
}

// FCM 토큰을 저장하는 함수
Future<void> saveUserFcmToken() async {
  kakao.User? user;
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // FCM 토큰 얻기
  String? fcmToken = await messaging.getToken();
  //로그인 확인
  bool isGoogleLoggedIn = await _googleSignIn.isSignedIn();
  bool isKakaoLoggedIn = false;

  try {
    await kakao.UserApi.instance.accessTokenInfo();
    isKakaoLoggedIn = true;
  } catch (e) {
    isKakaoLoggedIn = false;
  }

  //로그인된 소셜에 따라
  if (isGoogleLoggedIn) {
    if (currentUser?.email != null && fcmToken != null) {
      // 사용자 이메일에 따라 토큰 저장 (userDataMap 변수를 이용해서 사용자 데이터를 참조하세요)
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .update({"fcmToken": fcmToken});
    }
  } else if (isKakaoLoggedIn) {
    user = await kakao.UserApi.instance.me();
    if (user?.id != null && fcmToken != null) {
      // 사용자 이메일에 따라 토큰 저장 (userDataMap 변수를 이용해서 사용자 데이터를 참조하세요)
      FirebaseFirestore.instance
          .collection('users')
          .doc(user?.id.toString())
          .update({"fcmToken": fcmToken});
    }
  }
}

Future initialization(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));
}

Future<bool> isSignedInGoogle() async {
  return await _googleSignIn.isSignedIn();
}

Future<bool> isSignedInKakao() async {
  try {
    await kakao.UserApi.instance.accessTokenInfo();
    return true;
  } catch (e) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    bool isKakaoLoggedIn = await isSignedInKakao();
    bool isGoogleLoggedIn = await isSignedInGoogle();

    print(isKakaoLoggedIn);
    print(isGoogleLoggedIn);

    if (isKakaoLoggedIn || isGoogleLoggedIn) {
      return All_Page();
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ko', 'KO'),
          Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<Widget>(
          future: _getInitialScreen(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error occurred');
              } else {
                return snapshot.data!;
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        )
    );
  }
}