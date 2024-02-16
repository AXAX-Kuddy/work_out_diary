import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';

class TodayWorkOutCard extends StatelessWidget {
  const TodayWorkOutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorWhite,
      height: 300,
      inputContent: const [
        Column(children: [
          Text(
            "Upcoming Programs",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "유저 이름's 프로그램 이름",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "n주차 n일째",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ]),
      ],
    );
  }
}
