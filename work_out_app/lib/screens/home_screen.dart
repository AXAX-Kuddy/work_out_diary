import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:scale_button/scale_button.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/screens/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:spring_button/spring_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        const ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        WideButton(
          onTapUpFunction: () => context.read<provider.Store>().changePage(1),
          inputContent: const [
            SizedBox(
              width: 10,
            ),
            Text(
              "루틴 계획하러 가기",
              style: TextStyle(
                fontSize: 14,
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
        const TodayWorkOutCard(),
        const SizedBox(
          width: 100,
          height: 100,
          child: SpringButton(
            useCache: true,
            alignment: Alignment.center,
            scaleCoefficient: 0.75,
            duration: 1000,
            SpringButtonType.OnlyScale,
            Text("아무글자"),
          ),
        ),
      ],
    );
  }
}
