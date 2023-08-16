import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;

class portFolio extends StatefulWidget {
  const portFolio({super.key});

  @override
  State<portFolio> createState() => _portFolioState();
}

class _portFolioState extends State<portFolio> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  kakao.User? user;
  String? uid;
  String? email;

  void Determine_Uid() async {
    //로그인 확인
    bool isGoogleLoggedIn = await _googleSignIn.isSignedIn();
    bool isKakaoLoggedIn = false;

    try {
      await kakao.UserApi.instance.accessTokenInfo();
      isKakaoLoggedIn = true;
      user = await kakao.UserApi.instance.me();
    } catch (e) {
      isKakaoLoggedIn = false;
    }

    if (mounted) {
      setState(() {
        uid = isGoogleLoggedIn ? currentUser?.uid : isKakaoLoggedIn ? user?.id.toString() : null;
        email = isGoogleLoggedIn ? currentUser?.email : isKakaoLoggedIn ? user!.kakaoAccount!.email : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Determine_Uid();
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0 ,backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black),),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Pofol')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final pofol = snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(uid)
                                          .collection('selectPofol')
                                          .doc(email)
                                          .set({
                                        'Protein': pofol['Protein'],
                                        'Creatine': pofol['Creatine'],
                                        'Bcaa': pofol['Bcaa'],
                                        'Arginin': pofol['Arginin'],
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.grey[200]),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text('단백질: ${pofol['Protein']}'),
                                              Text('크레아틴: ${pofol['Creatine']}'),
                                              Text('아르기닌: ${pofol['Arginin']}'),
                                              Text('Bcaa: ${pofol['Bcaa']}'),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: QrImageView(
                                              data:
                                              '단백질: ${pofol['Protein']}g, 크레아틴: ${pofol['Creatine']}g, 아르기닌: ${pofol['Arginin']}g, BCAA: ${pofol['Bcaa']}g',
                                              version: QrVersions.auto,
                                              size: 110,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        return Center(
                          child: Container(),
                        );
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}