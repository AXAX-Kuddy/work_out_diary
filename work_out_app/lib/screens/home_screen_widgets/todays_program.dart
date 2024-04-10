import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class TodayWorkOutCard extends StatefulWidget {
  const TodayWorkOutCard({
    super.key,
  });

  @override
  State<TodayWorkOutCard> createState() => _TodayWorkOutCardState();
}

class _TodayWorkOutCardState extends State<TodayWorkOutCard> {
  late String _userName;

  List<String> randomAnnounce = [
    "오늘도 한탕 해볼까요?",
    "오늘도 힘내자구요!",
    "힘들어도 아자아자!",
    "이 앞, 압.도.정.진 있으라",
    "더 큰 근육, 더 강한 힘!",
    "조금 더 강해질 그 순간을 위해!",
    "노력은 결코 배신하지 않아요!",
  ];

  int randomSelector() {
    int number = Random().nextInt(randomAnnounce.length);
    return number;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userName = context.watch<provider.Store>().userInfo["userName"];
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorWhite,
      height: 300,
      inputContent: [
        Column(
          children: [
            Column(
              children: [
                Text(
                  "$_userName님! 반가워요!",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  randomAnnounce[randomSelector()],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Text(
              "Upcoming Programs",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: List.generate(
                7,
                (index) => Text("$index번째 루틴"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
