//기본
import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/palette.dart' as palette;

//화면 위젯
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';

//패키지들

//아이콘
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const PlanningScreen(),
        const WorkOutScreen(),
        const DotsPointScreen(),
      ][pageNum],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageNum,
        onTap: (pageIndex) {
          setState(() {
            pageNum = pageIndex;
          });
        },
        backgroundColor: palette.bgFadeColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: LineIcon.home(),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.calendar(),
            label: "Planning",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.dumbbell(),
            label: "Work Out",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.raisedFist(),
            label: "DOTS Point",
          ),
        ],
      ),
    );
  }
}
