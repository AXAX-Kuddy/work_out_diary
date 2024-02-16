import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        WidgetsBox(
          height: 90,
          backgroundColor: palette.bgColor,
          inputContent: const [
            Text(
              "Planning",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
