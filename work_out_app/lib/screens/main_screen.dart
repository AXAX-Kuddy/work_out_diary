import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/screens/dots_point_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const PlanningScreen(),
    const WorkOutScreen(),
    const DotsPointScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var pageNum = context.watch<provider.Store>().pageNum;
    var changePage = context.watch<provider.Store>().changePage;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(pageNum),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: palette.bgFadeColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
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
              icon: LineIcon.raisedFist(), label: "DOTS Point"),
        ],
        currentIndex: pageNum,
        onTap: (index) => changePage(index),
      ),
    );
  }
}
