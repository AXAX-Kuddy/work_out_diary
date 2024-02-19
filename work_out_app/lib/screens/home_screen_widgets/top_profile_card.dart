import 'package:flutter/material.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorYelGreen,
      verticalAxis: CrossAxisAlignment.center,
      inputContent: [
        const Text(
          "유저 이름",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "스쿼트",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "100",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "벤치프레스",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "100",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "데드리프트",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "100",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "중급자",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: palette.tierMiddle,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
