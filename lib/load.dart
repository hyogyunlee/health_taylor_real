import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_taylor/ev_provider.dart';
import 'package:health_taylor/home.dart';
import 'package:health_taylor/pages/All_Pages.dart';
import 'package:health_taylor/pages/onboarding_page.dart';
import 'package:provider/provider.dart';

class load extends StatefulWidget {
  final bool isFromHome_Page;

  const load({required this.isFromHome_Page});

  @override
  State<load> createState() => _loadState();
}
class _loadState extends State<load> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: MultiProvider(
              // ChangeNotifierProvider 통해 변화에 대해 구독
              providers: [
                ChangeNotifierProvider(
                    create: (BuildContext context) => EvProvider())
              ],
              child: Home(), // home.dart
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.isFromHome_Page) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const All_Page()
                    ),
                  );
                }
                else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnBoardingPage(startPageIndex: 2),
                    ),
                  );
                }
              },
              child: Text("완료")),
        ],
      ),
    );
  }
}
