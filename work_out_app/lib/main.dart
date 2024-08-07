// ignore_for_file: unused_import

import 'dart:io';

//기본
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/screens/debug/debug_screen.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen.dart';
import 'package:work_out_app/util/util.dart';

import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/grid_loading_circle/loading_circle.dart';

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

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

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
        ChangeNotifierProvider(
          create: (context) => provider.PageNumber(),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late provider.MainStoreProvider mainStoreProvider;
  late provider.PageNumber pageNumber;

  @override
  void initState() {
    super.initState();
    mainStoreProvider = context.read<provider.MainStoreProvider>();
    pageNumber = context.read<provider.PageNumber>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isEdit = mainStoreProvider.userInfo[UserInfoField.isEdit];
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
    return Consumer<provider.PageNumber>(
      builder:
          (BuildContext context, provider.PageNumber pageNum, Widget? child) {
        return Scaffold(
          body: FutureBuilder(
              future: mainStoreProvider.loadPreferences(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    color: palette.bgColor,
                    child: const Center(
                      child: LoadingCircle(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    color: palette.bgColor,
                    child: const Center(
                      child: Text("사용자 데이터를 불러오지 못했습니다."),
                    ),
                  );
                } else {
                  return [
                    /// 전체 페이지
                    const HomeScreen(),
                    const DiaryScreen(),
                    const WorkoutLibrary(
                      showAddCustomButton: true,
                      showAppbarCloseButton: false,
                      showAddPlanningScreen: false,
                    ),
                    const DotsPointScreen(),
                    const DebugScreen(),
                  ][pageNumber.pageNum];
                }
              }),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageNumber.pageNum,
            onTap: (pageIndex) {
              setState(() {
                pageNumber.changePage(pageIndex);
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
      },
    );
  }
}
