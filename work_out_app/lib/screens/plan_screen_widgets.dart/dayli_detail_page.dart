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
import 'package:work_out_app/widgets/non_form_text_field.dart';

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
  List<maked.Set> tempoList = [];
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
                                key: ValueKey(index),
                                setIndex: index,
                                setInstance: sets[index],
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
                            maked.Set newSet = maked.Set();
                            workout.addSet(newSet);
                            setState(() {});
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
  final int setIndex;
  final maked.Set setInstance;
  final maked.Workout workoutInstance;
  final Function updateState;

  const SetDetail({
    super.key,
    required this.setIndex,
    required this.setInstance,
    required this.workoutInstance,
    required this.updateState,
  });

  @override
  State<SetDetail> createState() => _SetDetailState();
}

class _SetDetailState extends State<SetDetail> {
  late final maked.Workout _workout = widget.workoutInstance;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  final bool _weightValid = false;
  bool _repsValid = false;

  @override
  void initState() {
    super.initState();
    widget.setInstance.setIndex = widget.setIndex;
  }

  void deleteSet() {
    int deleteIndex = widget.setInstance.setIndex!;

    setState(() {
      _workout.removeSet(widget.setInstance);
    });

    for (int i = 0; i < _workout.sets!.length; i++) {
      if (_workout.sets![i].setIndex! > deleteIndex) {
        _workout.sets![i].setIndex = _workout.sets![i].setIndex! - 1;
      }
    }
    widget.updateState();
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
                "${widget.setInstance.setIndex! + 1}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomTextField2(
                width: 90,
                height: 45,
                valid: _weightValid,
                textInputType: TextInputType.number,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: CustomTextField2(
                controller: _repsController,
                width: 90,
                height: 45,
                valid: _repsValid,
                textInputType: TextInputType.number,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
                onSubmitted: (value) {
                  if (value.length > 1) {
                    setState(() {
                      _repsController.text = value;
                      _repsValid = true;
                    });
                  } else if (value.isEmpty) {
                    setState(() {
                      _repsController.text = "0";
                      _repsValid = false;
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () => deleteSet(),
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
