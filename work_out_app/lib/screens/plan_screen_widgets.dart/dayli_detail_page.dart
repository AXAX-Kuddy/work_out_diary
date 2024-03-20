import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/drop_down.dart';
import 'package:work_out_app/widgets/text_field.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:work_out_app/make_program.dart' as maked;
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

class DailyDetail extends StatefulWidget {
  final int dayNum;
  final List<maked.Workout>? workouts;
  const DailyDetail({
    super.key,
    required this.dayNum,
    required this.workouts,
  });

  @override
  State<DailyDetail> createState() => _DailyDetailState();
}

class _DailyDetailState extends State<DailyDetail> {
  late List<maked.Workout>? workouts = widget.workouts;

  final List<String> rpeList = [
    "5",
    "5.5",
    "6",
    "6.5",
    "7",
    "7.5",
    "8",
    "8.5",
    "9",
    "9.5",
    "10"
  ];

  bool rpeinput = false;

  void changedRPEcheckCondition() {
    setState(() {
      rpeinput = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          inputContent: [
            Text(
              "${widget.dayNum + 1}일차 세부 운동 설정",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: workouts!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              //운동 인스턴스
              maked.Workout workout = workouts![index];

              List<maked.Set>? sets = workout.sets;

              return WidgetsBox(
                backgroundColor: palette.bgColor,
                border: Border.all(
                  color: palette.cardColorGray,
                ),
                horizontalAxis: MainAxisAlignment.center,
                verticalAxis: CrossAxisAlignment.center,
                inputContent: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${workout.name}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: palette.cardColorWhite,
                          ),
                        ),
                        const Divider(
                          // color: palette.cardColorWhite,
                          thickness: 1,
                          height: 10,
                        ),
                        CustomDropDownButton(
                          hint: "RPE",
                          selectChecker: changedRPEcheckCondition,
                          itemList: rpeList,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "세트",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "중량",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "횟수",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "삭제",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Column(
                          children: List.generate(
                            sets!.length,
                            (int index) {
                              return SetDetail(
                                setNum: index,
                                workoutInstance: workout,
                                updateState: () {
                                  setState(() {
                                    sets;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              maked.Set newSet = maked.Set(
                                setIndex: sets.length,
                              );
                              workout.addSet(newSet);
                              print("추가된 세트는 : ${newSet.setIndex}세트");
                              print("총 세트 수는: ${sets.length}세트");
                            });
                          },
                          child: const Text("세트 추가하기"),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class SetDetail extends StatefulWidget {
  int setNum;
  final maked.Workout workoutInstance;
  final Function updateState;

  SetDetail({
    super.key,
    required this.setNum,
    required this.workoutInstance,
    required this.updateState,
  });

  @override
  State<SetDetail> createState() => _SetDetailState();
}

class _SetDetailState extends State<SetDetail> {
  late final maked.Workout _workout = widget.workoutInstance;
  late final maked.Set _set = _workout.sets![widget.setNum];

  final _weightFormKey = GlobalKey<FormState>();
  final _repsFormKey = GlobalKey<FormState>();

  final bool _weightValid = false;
  bool _repsValid = false;

  void deleteSet(maked.Set set) async {
    int deleteIndex = set.setIndex;
    _workout.removeSet(set);
    print("삭제된 세트는 : ${set.setIndex}세트");

    for (int i = 0; i < _workout.sets!.length; i++) {
      if (set.setIndex > deleteIndex) {
        set.setIndex--;
      }
    }
    print("총 세트 수는: ${_workout.sets!.length}세트");
    await widget.updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "${_set.setIndex}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CoustomTextField(
                key: _weightFormKey,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
                textInputType: TextInputType.number,
                width: 100,
                height: 60,
                isValid: _weightValid,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: CoustomTextField(
                key: _repsFormKey,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
                textInputType: TextInputType.number,
                width: 100,
                height: 60,
                isValid: _repsValid,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _repsValid = false;
                    });
                    return "값을 입력해주세요";
                  } else {
                    setState(() {
                      _repsValid = true;
                    });
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  deleteSet(_set);
                },
                icon: const Icon(
                  LineIcons.trash,
                ),
                color: Colors.red,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
