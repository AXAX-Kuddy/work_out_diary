import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late String _userName;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(
            height: 250,
            child: FutureBuilder(
              future: database.getRoutines(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Routine>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("데이터를 가져오지 못했습니다."),
                  );
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverGrid.builder(
                        itemCount: snapshot.data?.length ?? 10,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 4.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final routines = snapshot.data;

                          return Container(
                            alignment: Alignment.center,
                            color: palette.cardColorYelGreen,
                            child: const Text(
                              "아무글자",
                              style: TextStyle(
                                fontSize: 15,
                                color: palette.bgColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
