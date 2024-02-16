import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/home_screen_widgets/lets_start_button.dart';
import 'package:work_out_app/screens/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_page.dart';

class HomeScreen extends StatelessWidget {
  final Function changePage;

  const HomeScreen({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      inputContent: [
        const ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        StartButton(
          changePage: changePage,
        ),
        const SizedBox(
          height: 15,
        ),
        const TodayWorkOutCard(),
      ],
    );
  }
}
