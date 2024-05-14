import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:work_out_app/keys.dart';
import 'package:work_out_app/screens/home_screen.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/palette.dart' as palette;

class WorkoutCompleteScreem extends StatelessWidget {
  const WorkoutCompleteScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        Text(
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
          child: Text(
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
