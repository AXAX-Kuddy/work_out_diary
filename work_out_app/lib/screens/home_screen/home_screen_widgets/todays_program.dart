import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/provider/store.dart' as provider;

class TodayWorkOutCard extends StatefulWidget {
  const TodayWorkOutCard({
    super.key,
  });

  @override
  State<TodayWorkOutCard> createState() => _TodayWorkOutCardState();
}

class _TodayWorkOutCardState extends State<TodayWorkOutCard> {
  final database = AppDatabase();
  final List<Routine> routineData = [];
  late String _userName;

  Future<void> getRoutines() async {
    final data = await database.select(database.routines).get();
    print(data);
    routineData.addAll(data);
  }

  final List<String> randomAnnounce = [
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
  void initState() {
    super.initState();
    getRoutines();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userName = provider.MainStore.userInfo[UserInfoField.userName];
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      backgroundColor: palette.cardColorWhite,
      height: 300,
      children: [
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                routineData.isEmpty ? 1 : routineData.length,
                (index) {
                  if (routineData.isEmpty) {
                    return const Text("루틴이 비어있어요!");
                  } else {
                    return Text("${routineData[index].date}");
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
