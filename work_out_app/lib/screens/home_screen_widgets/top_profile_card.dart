import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late String userName;
  late String _squatWeight;
  late String _benchWeight;
  late String _deadWeight;
  late String _dotsPoint;

  List<String> tierList = [
    "초보자",
    "입문자",
    "중급자",
    "숙련자",
    "선수",
  ];

  List<Color> colorList = [
    palette.tierLow,
    palette.tierMiddleLow,
    palette.tierMiddle,
    palette.tierMiddleHigh,
    palette.tierHigh,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userName = context.read<provider.Store>().userInfo["userName"];
    _squatWeight = context.read<provider.Store>().userInfo["userSBD"]["스쿼트"];
    _benchWeight = context.read<provider.Store>().userInfo["userSBD"]["벤치프레스"];
    _deadWeight = context.read<provider.Store>().userInfo["userSBD"]["데드리프트"];
    _dotsPoint = context.read<provider.Store>().userInfo["dotsPoint"];
  }

  int userTier(String dotsPoint) {
    var point = num.parse(dotsPoint);
    if (point > 400) {
      return 4;
    } else if (point > 300) {
      return 3;
    } else if (point > 200) {
      return 2;
    } else if (point > 100) {
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
                  _squatWeight,
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
                  _benchWeight,
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
                  _deadWeight,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              tierList[userTier(_dotsPoint)],
              style: const TextStyle(
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
                color: colorList[userTier(_dotsPoint)],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
