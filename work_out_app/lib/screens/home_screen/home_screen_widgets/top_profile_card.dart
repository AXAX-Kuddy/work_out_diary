import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';

import '../../../util/util.dart';

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
                    Tier.selectTierName(dots),
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
                      color: Tier.selectTierColor(dots),
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
