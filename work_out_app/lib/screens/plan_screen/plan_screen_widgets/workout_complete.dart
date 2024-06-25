import 'package:flutter/material.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/router/main_screen_router.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        const Row(
          children: [
            Text(
              "운동 완료창",
              style: TextStyle(
                color: palette.cardColorWhite,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            MainScreenRouter.removeUntilAndGo(context);
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
