import 'package:flutter/material.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: const [
            Text(
              "Create Your Program",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        WidgetsBox(
          backgroundColor: palette.bgColor,
          height: 40,
          horizontalAxis: MainAxisAlignment.start,
          inputContent: const [
            Text(
              "1주차",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) {
                return const SelectWorkOut();
              })),
            );
          },
          child: const Text("+운동 추가"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("+주차 추가"),
        ),
      ],
    );
  }
}
