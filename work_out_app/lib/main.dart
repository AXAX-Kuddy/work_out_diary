//기본
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/make_program.dart' as maked;
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/keys.dart';

//화면 위젯
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';
import 'package:work_out_app/dump/input_userInfo.dart';

//패키지들
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:animations/animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart';

//아이콘
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

//데이터베이스
import 'package:work_out_app/database.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => provider.MainStoreProvider(provider.MainStore()),
        ),
        ChangeNotifierProvider(
          create: (context) => provider.WorkoutListStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => provider.RoutineProvider(provider.Routine()),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        theme: ThemeData(
            fontFamily: "Pretendard",
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              backgroundColor: palette.bgColor,
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ))),
        home: const MyApp(),
      ),
    ),
  );
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool notWriteUserInfo = true;
  late provider.MainStoreProvider mainStoreProvider;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (store.infoChecker(store.userInfo) == false && notWriteUserInfo) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => UserInfoPage(
    //           updateInfo: updateUserInfo,
    //           userInfo: store.userInfo,
    //           notWriteUserInfo: notWriteUserInfo,
    //         ),
    //       ),
    //     );
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainStoreProvider = context.watch<provider.MainStoreProvider>();
  }

  void updateUserInfo(bool infoCondition) {
    setState(() {
      infoCondition = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        // const PlanningScreen(),
        const WorkOutScreen(),
        const DotsPointScreen(),
      ][PageNumber.pageNum],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: PageNumber.pageNum,
        onTap: (pageIndex) {
          setState(() {
            PageNumber.changePage(pageIndex);
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
          // BottomNavigationBarItem(
          //   icon: LineIcon.calendar(),
          //   label: "Planning",
          // ),
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
