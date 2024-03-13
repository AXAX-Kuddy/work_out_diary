import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/screens/input_userInfo.dart';
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';
import 'package:work_out_app/screens/input_userInfo.dart';
import 'package:work_out_app/screens/main_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool notWriteUserInfo = true;
  var userInfo;
  var infoChecker;
  var pageNum;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userInfo = context.read<provider.Store>().userInfo;
    infoChecker = context.read<provider.Store>().infoChecker;
    pageNum = context.read<provider.Store>().pageNum;
  }

  void updateUserInfo(bool infoCondition) {
    setState(() {
      infoCondition = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (infoChecker != null &&
        infoChecker(userInfo) == false &&
        notWriteUserInfo) {
      return UserInfoPage(
        updateInfo: updateUserInfo,
        userInfo: userInfo,
        notWriteUserInfo: notWriteUserInfo,
      );
    } else {
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
