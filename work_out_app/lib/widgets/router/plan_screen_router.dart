import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';

class PlanningScreenRouter extends Navigator {
  const PlanningScreenRouter({
    super.key,
  });

  static Future<dynamic> go(BuildContext context) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const PlanningScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
