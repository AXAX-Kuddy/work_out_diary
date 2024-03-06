//기본
import 'package:flutter/material.dart';
import 'package:work_out_app/screens/input_userInfo.dart';

import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/palette.dart' as palette;

//화면 위젯
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';

//패키지들
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';

//아이콘
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => provider.Store(),
        ),
        ChangeNotifierProvider(
          create: (context) => provider.WorkOutListStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => provider.UserProgramListStore(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Pretendard",
        ),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var userInfo = context.read<provider.Store>().userInfo;
    var infoCheck = context.read<provider.Store>().infoChecker;

    if (infoCheck(userInfo) == false) {
      // 유저가 입력정보를 채우지 않았을 시
      return const UserInfoPage();
    } else {
      return Scaffold(
        body: [
          const HomeScreen(),
          const PlanningScreen(),
          const WorkOutScreen(),
          const DotsPointScreen(),
        ][context.watch<provider.Store>().pageNum],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<provider.Store>().pageNum,
          onTap: (pageIndex) {
            context.read<provider.Store>().changePage(pageIndex);
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
}
