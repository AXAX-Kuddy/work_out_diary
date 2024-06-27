//기본
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/screens/debug/debug_screen.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen.dart';

import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/util/keys.dart';

//화면 위젯
import 'package:work_out_app/screens/home_screen/home_screen.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen.dart';
import 'package:work_out_app/screens/dots_screen/dots_point_screen.dart';
import 'package:work_out_app/dump/input_userInfo.dart';

//패키지들
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:animations/animations.dart';

//아이콘
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

//데이터 베이스
import 'package:drift/drift.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase database = AppDatabase();

  for (var value in WorkoutListKeys.values) {
    final workoutData = await database.getWorkoutMenusByPart(value);
    if (workoutData.isEmpty) {
      await database.insertInitialData(database);
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => provider.MainStoreProvider(),
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
            appBarTheme: const AppBarTheme(
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
  late provider.MainStoreProvider mainStoreProvider;

  @override
  void initState() {
    super.initState();
    mainStoreProvider = context.read<provider.MainStoreProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isEdit = mainStoreProvider.getUserInfo()[UserInfoField.isEdit];
      if (!isEdit) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const UserInfoScreen();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const DiaryScreen(),
        const WorkoutLibrary(
          showAppbarCloseButton: false,
          showAddPlanningScreen: false,
        ),
        const DotsPointScreen(),
        const DebugScreen(),
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
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.calendar(),
            label: "일지",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.dumbbell(),
            label: "라이브러리",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.raisedFist(),
            label: "DOTS 포인트",
          ),
          BottomNavigationBarItem(
            icon: LineIcon.bug(),
            label: "디버그",
          ),
        ],
      ),
    );
  }
}
