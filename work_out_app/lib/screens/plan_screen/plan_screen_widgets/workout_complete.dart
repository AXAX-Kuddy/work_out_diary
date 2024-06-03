import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_out_app/screens/home_screen/home_screen.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;

class WorkoutCompleteScreem extends StatelessWidget {
  const WorkoutCompleteScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        const Text(
          "운동 완료창",
          style: TextStyle(
            color: palette.cardColorWhite,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }),
              (route) => false,
            );
          },
          child: const Text(
            "운동 완료",
            style: TextStyle(
              color: palette.cardColorWhite,
            ),
          ),
        ),
      ],
    );
  }
}
