import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/QR_create.dart';
import 'package:health_taylor/auth/login_page.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);

Future<void> signOut() async {
  try {
    await _googleSignIn.signOut();
    await kakao.UserApi.instance.logout();
  } catch (error) {
    print("Error signing out: $error");
  }
}

Future<String?> getNickname() async {
  String? nickname;
  try {
    GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
    if (googleUser != null) {
      nickname = googleUser.displayName;
      return nickname;
    } else {
      final kakaoUser = await kakao.UserApi.instance.me();
      if (kakaoUser.properties != null) {
        nickname = kakaoUser.properties!['nickname'];
        return nickname;
      }
    }
  } catch (error) {
    print("Error fetching user name: $error");
  }
  return '';
}

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String nickname = '???';
  @override
  void initState() {
    super.initState();
    getNickname().then((value) {
      setState(() {
        nickname = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Text(
              '$nickname님의 추천 보충제 포트폴리오? 입니다',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: ElevatedButton(
                      onPressed: () {
                        final qrData = '단백질: 28,'
                            '아르기닌: 13,'
                            'BCAA: 9';
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QR_create(data: qrData),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text('마이프로틴 아이솔레이트 초코'),
                          Divider(thickness: 2, color: Colors.grey[500]),
                          Text('성분? 추천이유? : $nickname님은 유당불내증이 있어서 블라블라'),
                          Text(
                            '단백질 28g 아르기닌 13g BCAA 9g',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: ElevatedButton(
                      onPressed: () {
                        final qrData = '단백질: 23,'
                            '아르기닌: 15,'
                            'BCAA: 7';
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QR_create(data: qrData),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('싸이베이션 BCAA 레몬라임'),
                          Divider(thickness: 2, color: Colors.grey[500]),
                          Text('성분? 추천이유? : $nickname님은 상큼한맛을 좋아함 블라블라'),
                          Text(
                            '단백질 23g 아르기닌 5g BCAA7g',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
