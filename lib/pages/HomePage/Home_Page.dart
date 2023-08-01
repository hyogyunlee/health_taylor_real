import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_taylor/load.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:health_taylor/pages/my_detail/body_detail.dart';
import 'package:health_taylor/pages/my_detail/category_detail.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {
  final currentUser = FirebaseAuth.instance.currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  kakao.User? user;
  String? uid;

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
        uid = isGoogleLoggedIn ? currentUser?.uid : isKakaoLoggedIn ? user?.id
            .toString() : null;
      });
    }
  }
  List productList = [
    {
      "id": 1,
      "pofol": Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/combat_protein.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '컴뱃 프로틴: 30g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/extream_bcaa.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '익스트림 BCAA: 5g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/now_arginin.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '나우 아르기닌: 2g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ])
    },
    {
      "id": 2,
      "pofol": Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/synta_protein.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '신타 프로틴: 23g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/newtri_bcaa.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '뉴트리 BCAA: 7g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/now_maca.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '나우 마카: 5g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ])
    },
    {
      "id": 3,
      "pofol": Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/select_protein.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '셀렉스 프로틴: 30g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/xtend_bcaa.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '엑스텐드 BCAA: 10g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/extream_arginin.png',
              scale: 3,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '익스트림 아르기닌 10g',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ])
    }
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Determine_Uid();
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 44, 91, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    'assets/ht.png',
                    scale: 5,
                  ),
                ),
                Center(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '신체정보',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BodyDetail(
                                              height: data['height'],
                                              weight: data['weight'],
                                              fat: data['fat'],
                                              muscle: data['muscle']),
                                        ));
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '키: ${data['height']} cm',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '몸무게: ${data['weight']} kg',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '체지방률: ${data['fat']} %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '골격근량: ${data['muscle']} kg',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryDetail(
                                                      goal: data['goal'],
                                                      brand: data['brand'],
                                                      category:
                                                      data['category'],
                                                      taste: data['taste'],
                                                      disease: data['disease'],
                                                      family: data['family']),
                                            ));
                                      },
                                      child: Container(
                                        width: width / 2.3,
                                        height: 200,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '현재목표',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlue[200],
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12)),
                                              child: Text(
                                                data['goal'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 30),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const load(isFromHome_Page:true),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: width / 2.3,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/health_information.png',
                                            ),
                                            Text('건강정보 불러오기', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '추천 보충제 포트폴리오',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: CarouselSlider(
                              items: productList
                                  .map(
                                    (item) => Center(
                                  child: item['pofol'],
                                ),
                              )
                                  .toList(),
                              carouselController: carouselController,
                              options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 2,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: productList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: currentIndex == entry.key ? 7 : 7,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: currentIndex == entry.key
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}