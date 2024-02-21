import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen_widgets.dart/routine_page.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

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
        ),
        WideButton(
          onTapUpFunction: () => context.read<provider.Store>().changePage(2),
          height: 80,
          inputContent: const [
            SizedBox(
              width: 10,
            ),
            Text(
              "루틴 없이 운동 바로 시작하기",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            LineIcon(
              LineIcons.angleRight,
              size: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        WideButton(
          onTapUpFunction: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoutinePage(),
              ),
            );
          },
          height: 80,
          inputContent: const [
            SizedBox(
              width: 10,
            ),
            Text(
              "새로운 루틴 만들기",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            LineIcon(
              LineIcons.angleRight,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }
}
