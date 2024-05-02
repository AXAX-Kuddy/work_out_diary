import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});
  final double squat = provider.MainStore
      .userInfo[provider.UserInfoField.userSBD][provider.SBDkeys.squat];

  final double bench = provider.MainStore
      .userInfo[provider.UserInfoField.userSBD][provider.SBDkeys.benchPress];

  final double dl = provider.MainStore.userInfo[provider.UserInfoField.userSBD]
      [provider.SBDkeys.deadlift];

  final double dots =
      provider.MainStore.userInfo[provider.UserInfoField.dotsPoint];

  final List<String> tierList = [
    "초보자",
    "입문자",
    "중급자",
    "숙련자",
    "고급자",
  ];

  final List<Color> colorList = [
    palette.tierLow,
    palette.tierMiddleLow,
    palette.tierMiddle,
    palette.tierMiddleHigh,
    palette.tierHigh,
  ];

  int userTier(String dotsPoint) {
    var point = num.parse(dotsPoint);
    if (point > 550) {
      return 4;
    } else if (point > 500) {
      return 3;
    } else if (point > 450) {
      return 2;
    } else if (point > 400) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorYelGreen,
      verticalAxis: CrossAxisAlignment.center,
      inputContent: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "스쿼트",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  squat.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "벤치프레스",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  bench.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "데드리프트",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dl.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  tierList[userTier(dots.toString())],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: colorList[userTier(dots.toString())],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$dots PT",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
