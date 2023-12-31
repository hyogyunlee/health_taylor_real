import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/auth/login_page.dart';
import 'package:health_taylor/pages/All_Pages.dart';
import 'package:health_taylor/pages/SocialPage/detail_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  kakao.KakaoSdk.init(nativeAppKey: 'a142c3efae28bc1a3df7e1b83e833b3f');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  String? postId;
  if (initialMessage != null) {
    postId = initialMessage.data['postId'];
  }
  runApp(MyApp(initialPostId: postId,));
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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  final String? initialPostId;

  const MyApp({Key? key, this.initialPostId}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  void initState() { // <-- initState method
    super.initState();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var postId = message.data['postId'];
      var commentId = message.data['commentId'];

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailPage(postId: postId, title: '', content: '', user: '', post_author_uid: '', time: '', img: '',)));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var postId = message.data['postId'];
      var commentId = message.data['commentId'];

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailPage(postId: postId, title: '', content: '', user:'', post_author_uid:'', time:'', img:'',)));
    });

  }

  @override
  Widget build(BuildContext context) {
    if(widget.initialPostId != null){
      return MaterialApp(
        home: DetailPage(postId: widget.initialPostId, title: '', content: '', user: '', post_author_uid: '', time: '', img: '',)
      );
    }
    else {
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
}