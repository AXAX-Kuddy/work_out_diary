import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late provider.PageNumber pageNum;

  final double squat =
      provider.MainStore.userInfo[UserInfoField.userSBD][SBDkeys.squat];

  final double bench =
      provider.MainStore.userInfo[UserInfoField.userSBD][SBDkeys.benchPress];

  final double dl =
      provider.MainStore.userInfo[UserInfoField.userSBD][SBDkeys.deadLift];

  final double dots = provider.MainStore.userInfo[UserInfoField.dotsPoint];

  final List<String> tierList = [
    "비기너",
    "주니어",
    "아마추어",
    "시니어",
    "어드밴스드 리프터",
    "프로 리프터",
  ];

  final List<Color> colorList = [
    palette.tierLow,
    palette.tierMiddleLow,
    palette.tierMiddle,
    palette.tierMiddleHigh,
    palette.tierHigh,
    palette.tierVeryHigh,
  ];

  int userTier(double dotsPoint) {
    if (dotsPoint > 450) {
      return 5;
    } else if (dotsPoint >= 400) {
      return 4;
    } else if (dotsPoint >= 350) {
      return 3;
    } else if (dotsPoint >= 300) {
      return 2;
    } else if (dotsPoint >= 200) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    pageNum = context.read<provider.PageNumber>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WideButton(
      onTapUpFunction: () {
        pageNum.changePage(3);
      },
      tapColor: palette.cardColorYelGreenClicked,
      unTapColor: palette.cardColorYelGreen,
      height: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                    tierList[userTier(dots)],
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
                      color: colorList[userTier(dots)],
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
      ),
    );
  }
}
