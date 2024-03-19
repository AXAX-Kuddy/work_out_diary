import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/drop_down.dart';
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
                  Column(
                    children: [
                      Text(
                        "${workout.name}",
                        style: TextStyle(
                          fontSize: 20,
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
                        hint: "Target @",
                        selectChecker: changedRPEcheckCondition,
                        itemList: rpeList,
                      ),
                      Column(
                        children: List.generate(
                          sets!.length,
                          (int index) {
                            return SetDetail(
                              workoutInstance: workout,
                              setInstance: sets[index],
                              updateState: () {
                                setState(() {
                                  sets;
                                  print(sets.length);
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
                              setNum: sets.length,
                            );
                            workout.addSet(newSet);
                            print("추가된 세트는 : ${newSet.setNum}세트");
                            print("총 세트 수는: ${sets.length}세트");
                          });
                        },
                        child: const Text("세트 추가하기"),
                      )
                    ],
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
  final maked.Workout workoutInstance;
  final maked.Set setInstance;
  final Function updateState;

  const SetDetail({
    super.key,
    required this.setInstance,
    required this.workoutInstance,
    required this.updateState,
  });

  @override
  State<SetDetail> createState() => _SetDetailState();
}

class _SetDetailState extends State<SetDetail> {
  late final maked.Set _set = widget.setInstance;
  late final maked.Workout _workout = widget.workoutInstance;

  void deleteSet() {
    setState(() {
      _workout.removeSet(_set);
      widget.updateState();
    });
    print("삭제된 세트는 : ${_set.setNum}세트");
    print("총 세트 수는: ${_workout.sets!.length}세트");
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      inputContent: [
        Text("${_set.setNum}"),
        IconButton(
          onPressed: () {
            deleteSet();
          },
          icon: const Icon(
            LineIcons.trash,
          ),
          color: Colors.red,
        )
      ],
    );
  }
}
