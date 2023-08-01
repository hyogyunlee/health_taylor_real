import 'package:flutter/material.dart';
import 'package:health_taylor/pages/HomePage/Home_Page.dart';
import 'package:health_taylor/pages/PortfolioPage/Portfolio_Page.dart';
import 'package:health_taylor/pages/SocialPage/social_page.dart';
import 'package:health_taylor/pages/ProfilePage/profile_page.dart';

class All_Page extends StatefulWidget {
  const All_Page({super.key});

  @override
  State<All_Page> createState() => _HomePageState();
}

class _HomePageState extends State<All_Page> {
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  Widget? _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const Home_Page();
      case 1:
        return Page2();
      case 2:
        return const SocialPage();
      case 3:
        return const ProfilePage();
    }
    return null;
  }

  Widget _bottomWidget() {
    return BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        // Color(0xff1e2c5b)
        backgroundColor: Color(0xFF18A5FD),
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        unselectedItemColor: Colors.blue[700],
        selectedItemColor: Colors.white,
        selectedFontSize: 13,
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.home_rounded,
                  color: Colors.blue[700],
                )),
            label: '홈',
            activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.home_rounded, color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.book_rounded,
                  color: Colors.blue[700],
                )),
            label: '포폴 제공',
            activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.book_rounded, color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.chat_bubble,
                  color: Colors.blue[700],
                )),
            label: '소셜',
            activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.chat_bubble, color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.person,
                  color: Colors.blue[700],
                )),
            label: '마이',
            activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.tag_faces_rounded, color: Colors.white)),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyWidget(),
        bottomNavigationBar: _bottomWidget(),
      ),
    );
  }
}
