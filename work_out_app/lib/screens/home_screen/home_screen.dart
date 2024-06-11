import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/provider/store.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  db.Routine panelCallingInstance = db.Routine(
    id: 0,
    routineName: "placeHold",
    date: DateTime.now(),
    isFavor: false,
    children: "",
  );
  final SlidingUpPanelController panelController = SlidingUpPanelController();

  void handlePanelController({
    required PanelControllerCommand command,
    db.Routine? routine,
  }) {
    switch (command) {
      case PanelControllerCommand.spread:
        setState(() {
          panelController.expand();
        });

      case PanelControllerCommand.hide:
        setState(() {
          panelController.hide();
        });

      default:
        null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: SizedBox(
        width: 180,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: palette.bgFadeColor,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const PlanningScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0); // 오른쪽에서 왼쪽으로 슬라이드
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LineIcon(
                  LineIcons.angleLeft,
                  color: palette.cardColorWhite,
                  size: 30,
                ),
                Text(
                  "운동 기록",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      slidingUpPanelWidget: CustomSlidingUpPanelWidget(
        onlyAnchor: false,
        controller: panelController,
        children: [
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return const Row(
              children: [],
            );
          }),
        ],
      ),
      children: [
        ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        TodayWorkOutCard(
          handlePanelController: handlePanelController,
        ),
      ],
    );
  }
}
