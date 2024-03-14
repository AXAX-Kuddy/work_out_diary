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
    "고급자",
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
    userName = context.watch<provider.Store>().userInfo["userName"] ?? "유저";
    _squatWeight =
        context.watch<provider.Store>().userInfo["userSBD"]["스쿼트"] ?? "100.5";
    _benchWeight =
        context.watch<provider.Store>().userInfo["userSBD"]["벤치프레스"] ?? "100.5";
    _deadWeight =
        context.watch<provider.Store>().userInfo["userSBD"]["데드리프트"] ?? "100.5";
    _dotsPoint =
        context.watch<provider.Store>().userInfo["dotsPoint"] ?? "1000";
  }

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  tierList[userTier(_dotsPoint)],
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
                    color: colorList[userTier(_dotsPoint)],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$_dotsPoint PT",
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
