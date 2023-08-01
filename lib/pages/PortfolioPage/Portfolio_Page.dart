import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/QR_create.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:google_fonts/google_fonts.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

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
  bool isliked = false;
  void toggleLike() {
    setState(() {
      isliked = !isliked;
    });
  }

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
    return Container(
      color: Color.fromRGBO(30, 44, 91, 1),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Text(
                '$nickname님의 추천 보충제 포트폴리오 입니다',
                style: GoogleFonts.blackHanSans(fontWeight: FontWeight.w700, fontSize: 30,color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.white, shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        final qrData = '단백질: 30,'
                            '아르기닌: 5,'
                            'BCAA: 2';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QR_create(data: qrData),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // 중앙 정렬된 그룹이 차지하는 공간을 최소한으로 유지하도록 설정합니다.
                                    children: [
                                      Icon(Icons.warning, color: Colors.yellow, size: 30),
                                      Text(
                                        '유당불내증',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.blackHanSans(color: Colors.black, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleLike,
                                child: Icon(
                                  isliked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: isliked ? Colors.red : Colors.black,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 2, color: Colors.grey[500]),
                          Text('단백질 30g (컴뱃 프로틴)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('BCAA 5g (익스트림)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('아르기닌 2g (나우)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.white, shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        final qrData = '단백질: 23,'
                            'BCAA: 5,'
                            '마카: 7';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QR_create(data: qrData),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // 중앙 정렬된 그룹이 차지하는 공간을 최소한으로 유지하도록 설정합니다.
                                    children: [
                                      Icon(Icons.warning, color: Colors.yellow, size: 30),
                                      Text(
                                        '등드름',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.blackHanSans(color: Colors.black, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleLike,
                                child: Icon(
                                  isliked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: isliked ? Colors.red : Colors.black,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 2, color: Colors.grey[500]),
                          Text('단백질 23g (아이언맥스)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('BCAA 7g (뉴트리)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('마카 5g (나우)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.white, shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        final qrData = '단백질: 30,'
                            '아르기닌: 10,'
                            'BCAA: 10';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QR_create(data: qrData),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // 중앙 정렬된 그룹이 차지하는 공간을 최소한으로 유지하도록 설정합니다.
                                    children: [
                                      Icon(Icons.warning, color: Colors.yellow, size: 30),
                                      Text(
                                        '고혈압',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.blackHanSans(color: Colors.black, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: toggleLike,
                                child: Icon(
                                  isliked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: isliked ? Colors.red : Colors.black,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 2, color: Colors.grey[500]),
                          Text('단백질 30g (셀렉스)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('BCAA 10g (엑스텐드)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                          Text('아르기닌 10g (익스트림)', textAlign: TextAlign.center, style: GoogleFonts.blackHanSans(color: Colors.black,fontSize: 20),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
