import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
          child: Padding(
            padding: const EdgeInsets.symmetric(
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
      children: [
        ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        const TodayWorkOutCard(),
      ],
    );
  }
}