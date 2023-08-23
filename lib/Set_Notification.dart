import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;

GoogleSignIn _googleSignIn = GoogleSignIn();
kakao.User? user;
final currentUser = FirebaseAuth.instance.currentUser;

// 유저 정보 업데이트
void FirestoreUpload(bool value) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    await firestore.collection('users').doc(currentUser?.uid).set({
      'notification':value,
    },SetOptions(merge: true));
  } else if (isKakaoLoggedIn) {
    user = await kakao.UserApi.instance.me();
    await firestore.collection('users').doc(user?.id.toString()).set({
      'notification':value,
    },SetOptions(merge: true));
  }
}

class Set_Notification extends StatefulWidget {
  const Set_Notification({Key? key}) : super(key: key);

  @override
  _Set_NotificationState createState() => _Set_NotificationState();
}

class _Set_NotificationState extends State<Set_Notification> {

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    fetchNotificationStatus(); // Notification status fetch from Firebase when the widget starts.
  }

  void fetchNotificationStatus() async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot? ds;

    bool isGoogleLoggedIn=await _googleSignIn.isSignedIn();
    bool isKakaoLoggedin=false;

    try{
      await kakao.UserApi.instance.accessTokenInfo();
      isKakaoLoggedin=true;

    }catch(e){
      print(e);
    }


    if(isGoogleLoggedIn){
      ds=await firestore.collection('users').doc(currentUser?.uid).get();

    }else if(isKakaoLoggedin){
      user=await kakao.UserApi.instance.me();
      ds=await firestore.collection('users').doc(user?.id.toString()).get();

    }


    setState(() {
      this.isSwitched=ds?['notification'] ?? false; // 'ds'가 null인 경우 기본값으로 false 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
          'Set Notification',
          style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children:<Widget>[
            ListTile(
              title: Text('Notification'),
              trailing: Switch(
                value: isSwitched,
                onChanged:(value){
                  setState(() { // 스위치의 상태가 변경될 때마다 호출되는 콜백
                    isSwitched = value;
                    FirestoreUpload(isSwitched);
                  });
                },
              ),
            ),
          ],
        ),
    );
  }
}
