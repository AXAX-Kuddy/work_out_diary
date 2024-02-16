import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/home_screen_widgets/lets_start_button.dart';
import 'package:work_out_app/screens/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      inputContent: [
        ProfileCard(),
        SizedBox(
          height: 15,
        ),
        StartButton(),
      ],
    );
  }
}
