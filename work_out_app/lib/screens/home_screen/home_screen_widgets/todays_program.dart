import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/widgets/buttons/cancel_and_enter_buttons.dart';
import 'package:work_out_app/widgets/buttons/trash_can_button.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/widgets/dialog/custom_dialog.dart';
import 'package:work_out_app/widgets/grid_loading_circle/loading_circle.dart';
import 'package:work_out_app/widgets/router/plan_screen_router.dart';

class TodayWorkOutCard extends StatefulWidget {
  final void Function({
    required PanelControllerCommand command,
    db.Routine? routine,
  }) handlePanelController;

  const TodayWorkOutCard({
    super.key,
    required this.handlePanelController,
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
      height: 300,
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
          Expanded(
            child: FutureBuilder(
              future: database.getRoutines(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Routine>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: LoadingCircle(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("데이터를 가져오지 못했습니다."),
                  );
                } else {
                  final routines = snapshot.data!;

                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 13),
                    itemCount: routines.isEmpty ? 1 : routines.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (routines.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "🤔 루틴이 비어있습니다.",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                PlanningScreenRouter.go(context);
                              },
                              icon: const LineIcon(
                                LineIcons.angleRight,
                                color: palette.bgColor,
                              ),
                              label: const Text(
                                "운동 계획하러가기",
                                style: TextStyle(
                                  color: palette.bgColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              child: WideButton(
                                height: 41,
                                onTapUpFunction: () {
                                  setState(() {
                                    widget.handlePanelController(
                                      command: PanelControllerCommand.spread,
                                      routine: routines[index],
                                    );
                                  });
                                },
                                tapColor: palette.cardColorWhite,
                                unTapColor: palette.colorWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: palette.bgColor.withOpacity(0.6),
                                    offset: const Offset(0, 1.5),
                                    blurRadius: 2.5,
                                  ),
                                ],
                                child: Row(
                                  children: [
                                    Text(
                                      routines[index].routineName,
                                    ),
                                    const Spacer(),
                                    const LineIcon(
                                      LineIcons.angleRight,
                                      color: palette.bgColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TrashCanButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      children: [
                                        const Text(
                                          "정말로 삭제하시겠습니까?",
                                          style: TextStyle(
                                            color: palette.cardColorWhite,
                                          ),
                                        ),
                                        CancelAndEnterButton(
                                          onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                          onEnterTap: () {
                                            setState(() {
                                              database.removeRoutine(
                                                  routines[index]);
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
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
