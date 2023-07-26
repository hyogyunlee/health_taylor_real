import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_taylor/components/agePicker.dart';
import 'package:health_taylor/components/textfield.dart';
import 'package:health_taylor/pages/agree/agree.dart';
import 'package:health_taylor/pages/All_Pages.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  DateTime _dateTime = DateTime.now();

  bool diseaseNo = false;
  bool diseaseYes = false;
  bool proteinNo = false;
  bool proteinYes = false;
  bool femaleSelect = false;
  bool maleSelect = false;
  bool allCheck = false;
  bool Check1 = false;
  bool Check2 = false;
  bool Check3 = false;
  bool Check4 = false;

  final ageEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final heightEditingController = TextEditingController();
  final weightEditingController = TextEditingController();
  final brandEditingController = TextEditingController();
  final tasteEditingController = TextEditingController();
  final catergoryEditingController = TextEditingController();
  final goalEditingController = TextEditingController();
  final fatEditingController = TextEditingController();
  final muscleEditingController = TextEditingController();
  final diseaseEditingController = TextEditingController();
  final familyEditingController = TextEditingController();

  // 유저 정보 업데이트
  void update() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.email)
        .update({
      'gender': maleSelect ? 'male' : 'female',
      'age': ageEditingController.text,
      'nickname': nameEditingController.text,
      'height': heightEditingController.text,
      'weight': weightEditingController.text,
      'brand': proteinYes ? brandEditingController.text : '',
      'taste': proteinYes ? tasteEditingController.text : '',
      'category': proteinYes ? catergoryEditingController.text : '',
      'goal': goalEditingController.text,
      'fat': fatEditingController.text,
      'muscle': muscleEditingController.text,
      'disease': diseaseEditingController.text,
      'family': familyEditingController.text,
    });
  }

  void nextPage() {
    if (_currentPageIndex < 9) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  void previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
      setState(() {
        _currentPageIndex--;
      });
    }
  }

  void onDateTimeChanged(dateTime) {
    setState(() {
      _dateTime = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    nowpage() {
      return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Text(
          _currentPageIndex.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }

    nextButton(String txt) {
      return ElevatedButton(
          onPressed: () {
            nextPage();
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              fixedSize: Size(width, 50),
              backgroundColor: Colors.black),
          child: Text(
            txt,
            style: TextStyle(fontSize: 18),
          ));
    }

    deadButton(String txt) {
      return Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(fontSize: 18, color: Colors.grey[200]),
          ),
        ),
      );
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              //가입 동의
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(
                          style: ButtonStyle(),
                        ),
                        nowpage()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(23, 20, 25, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                '이용약관 동의',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                      shape: CircleBorder(),
                                      value: allCheck,
                                      onChanged: (value) {
                                        setState(() {
                                          allCheck = value!;
                                          Check1 = value;
                                          Check2 = value;
                                          Check3 = value;
                                          Check4 = value;
                                        });
                                      },
                                    ),
                                    const Text(
                                      '모두 동의',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: Colors.black,
                                          checkColor: Colors.white,
                                          shape: CircleBorder(),
                                          value: Check1,
                                          onChanged: (value) {
                                            setState(() {
                                              Check1 = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          '(필수) 개인정보보호방침 동의',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Agree(),
                                              ));
                                        },
                                        child: const Text(
                                          '보기',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: Colors.black,
                                          checkColor: Colors.white,
                                          shape: CircleBorder(),
                                          value: Check2,
                                          onChanged: (value) {
                                            setState(() {
                                              Check2 = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          '(필수) 서비스 이용약관 동의',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          '보기',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: Colors.black,
                                          checkColor: Colors.white,
                                          shape: CircleBorder(),
                                          value: Check3,
                                          onChanged: (value) {
                                            setState(() {
                                              Check3 = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          '(필수) 민감정보수집 및 이용동의',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          '보기',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: Colors.black,
                                          checkColor: Colors.white,
                                          shape: CircleBorder(),
                                          value: Check4,
                                          onChanged: (value) {
                                            setState(() {
                                              Check4 = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          '(선택) 민감정보수집 및 이용동의',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          '보기',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Check1 && Check2 && Check3 == true
                                ? nextButton('동의합니다')
                                : deadButton('동의합니다')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //온보딩1
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          style: ButtonStyle(),
                          onPressed: previousPage,
                        ),
                        nowpage()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 15, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  '가입을 축하드립니다! \n활용될 정보들을 입력해주세요',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 110.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              maleSelect = !maleSelect;
                                              maleSelect == true
                                                  ? femaleSelect = false
                                                  : femaleSelect = true;
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: maleSelect
                                                ? Colors.indigo[900]
                                                : Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              child: Icon(Icons.male)),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              femaleSelect = !femaleSelect;
                                              femaleSelect == true
                                                  ? maleSelect = false
                                                  : maleSelect = true;
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: femaleSelect
                                                ? Colors.pink
                                                : Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              child: Icon(Icons.female)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Column(
                                                children: [
                                                  BirthDatePicker(
                                                      onDateTimeChanged:
                                                          onDateTimeChanged,
                                                      initDateStr:
                                                          _dateTime.toString()),
                                                  Text(_dateTime.toString()),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, _dateTime);
                                                    },
                                                    child: Text('확인')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('취소')),
                                              ],
                                            ),
                                          );
                                        },
                                        child: const Text('나이')),
                                    Mytextfield(
                                        text: '나이',
                                        textEditingController:
                                            ageEditingController),
                                    Mytextfield(
                                        text: '닉네임',
                                        textEditingController:
                                            nameEditingController),
                                    Mytextfield(
                                        text: '키',
                                        textEditingController:
                                            heightEditingController),
                                    Mytextfield(
                                        text: '몸무게',
                                        textEditingController:
                                            weightEditingController),
                                  ],
                                ),
                              ),
                              (ageEditingController.text.isNotEmpty &&
                                      nameEditingController.text.isNotEmpty &&
                                      heightEditingController.text.isNotEmpty &&
                                      weightEditingController.text.isNotEmpty)
                                  ? nextButton('다음')
                                  : deadButton('다음')
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //온보딩2
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          style: ButtonStyle(),
                          onPressed: previousPage,
                        ),
                        nowpage()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '보충제를 섭취해본 경험이 있나요?',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          proteinNo = !proteinNo;
                                          proteinYes = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(proteinNo
                                              ? Icons.check_circle
                                              : Icons.check_circle_outline),
                                          SizedBox(width: 20),
                                          Expanded(child: Text('없어요')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          proteinYes = !proteinYes;
                                          proteinNo = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(proteinYes
                                              ? Icons.check_circle
                                              : Icons.check_circle_outline),
                                          SizedBox(width: 20),
                                          Expanded(child: Text('있어요')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (proteinYes)
                                    Column(
                                      children: [
                                        Mytextfield(
                                            text: '보충제 브랜드 및 이름',
                                            textEditingController:
                                                brandEditingController),
                                        Mytextfield(
                                            text: '보충제 맛',
                                            textEditingController:
                                                tasteEditingController),
                                        Mytextfield(
                                            text: '보충제 종류',
                                            textEditingController:
                                                catergoryEditingController),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              (brandEditingController.text.isNotEmpty &&
                                          tasteEditingController
                                              .text.isNotEmpty &&
                                          catergoryEditingController
                                              .text.isNotEmpty ||
                                      proteinNo)
                                  ? nextButton('다음')
                                  : deadButton('다음')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //온보딩3
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          style: ButtonStyle(),
                          onPressed: previousPage,
                        ),
                        nowpage()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '운동 목표를 적어주세요',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Mytextfield(
                                      text: '운동목표',
                                      textEditingController:
                                          goalEditingController),
                                  Mytextfield(
                                      text: '체지방률',
                                      textEditingController:
                                          fatEditingController),
                                  Mytextfield(
                                      text: '골격근량',
                                      textEditingController:
                                          muscleEditingController),
                                ],
                              ),
                              (goalEditingController.text.isNotEmpty &&
                                      fatEditingController.text.isNotEmpty &&
                                      muscleEditingController.text.isNotEmpty)
                                  ? nextButton('다음')
                                  : deadButton('다음')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //온보딩4
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          style: ButtonStyle(),
                          onPressed: previousPage,
                        ),
                        nowpage()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                '갖고있는 질병이나 가족력이 \n있으시다면 적어주세요',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          diseaseNo = !diseaseNo;
                                          diseaseYes = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(diseaseNo
                                              ? Icons.check_circle
                                              : Icons.check_circle_outline),
                                          SizedBox(width: 20),
                                          Expanded(child: Text('없어요')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          diseaseYes = !diseaseYes;
                                          diseaseNo = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(diseaseYes
                                              ? Icons.check_circle
                                              : Icons.check_circle_outline),
                                          SizedBox(width: 20),
                                          Expanded(child: Text('있어요')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (diseaseYes)
                                    Column(
                                      children: [
                                        Mytextfield(
                                            text: '질병',
                                            textEditingController:
                                                diseaseEditingController),
                                        Mytextfield(
                                            text: '가족력',
                                            textEditingController:
                                                familyEditingController),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            (diseaseEditingController.text.isNotEmpty &&
                                        familyEditingController
                                            .text.isNotEmpty ||
                                    diseaseNo)
                                ? ElevatedButton(
                                    onPressed: () {
                                      nextPage();
                                      update();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        fixedSize: Size(width, 50),
                                        backgroundColor: Colors.black),
                                    child: Text(
                                      '다음',
                                      style: TextStyle(fontSize: 18),
                                    ))
                                : deadButton('다음')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //온보딩5
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Text(
                        '???님이 입력하신 정보를 분석해 \n 보충제 포트폴리오를 추천해드리겠습니다',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: LottieBuilder.asset('assets/loading.json'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              )),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              backgroundColor: Colors.black),
                          child: const Text(
                            '일단 넘어가기',
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}