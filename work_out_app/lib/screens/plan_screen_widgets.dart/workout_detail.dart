import 'package:flutter/material.dart';
import 'package:work_out_app/make_program.dart' as maked;
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/screens/plan_screen.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/top_divider.dart';
import 'package:work_out_app/widgets/drop_down.dart';
import 'package:work_out_app/widgets/non_form_text_field.dart';

class WorkoutDetail extends StatefulWidget {
  final int index;
  final void Function(maked.Workout) removeWorkout;
  final maked.Workout workoutInstance;

  const WorkoutDetail({
    super.key,
    required this.index,
    required this.workoutList,
    required this.removeWorkout,
    required this.workoutInstance,
  });

  final List<maked.Workout> workoutList;

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  String target = "타겟 RPE";
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${widget.index + 1}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: palette.cardColorYelGreen,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.workoutInstance.name!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: palette.cardColorWhite,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String selectRpe = "0";
                    return Dialog(
                      backgroundColor: palette.bgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 300,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "목표 RPE를 선택해주세요!",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: palette.cardColorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropDownButton(
                                hint: "RPE",
                                textStyle: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                                itemList: rpeList,
                                itemTextStyle: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                                onChanged: (value) {
                                  selectRpe = value!;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectRpe = "0";
                                        target = "타겟 RPE";
                                        widget.workoutInstance.targetRpe =
                                            double.parse(selectRpe);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "초기화",
                                      style: TextStyle(
                                          color: palette.cardColorWhite),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (selectRpe == "0") {
                                        setState(() {
                                          widget.workoutInstance.targetRpe =
                                              double.parse(selectRpe);
                                          target = "타겟 RPE";
                                        });
                                      } else {
                                        setState(() {
                                          widget.workoutInstance.targetRpe =
                                              double.parse(selectRpe);
                                          target = selectRpe;
                                        });
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "확인",
                                      style: TextStyle(
                                        color: palette.cardColorYelGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Text(
                    "@$target",
                    style: TextStyle(
                      fontSize: 16,
                      color: palette.cardColorWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  LineIcon(
                    LineIcons.pen,
                    size: 17,
                    color: palette.cardColorWhite,
                  )
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(25),
                      backgroundColor: Colors.transparent,
                      content: Text(
                        "${widget.workoutInstance.name}를(을) 목록에서 삭제 하시겠습니까?",
                        style: TextStyle(
                          fontSize: 16,
                          color: palette.cardColorWhite,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "취소",
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.removeWorkout(widget.workoutInstance);
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "확인",
                                style: TextStyle(
                                  color: palette.cardColorYelGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const LineIcon(
                color: Colors.red,
                size: 24,
                LineIcons.trash,
              ),
            )
          ],
        ),
        const Divider(
          height: 20,
        ),
        const TopDivider(),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: List.generate(
            widget.workoutInstance.sets!.length,
            (index) {
              return Column(
                children: [
                  SetsDetail(
                    index: index,
                    setInstance: widget.workoutInstance.sets![index],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                if (widget.workoutInstance.sets!.isNotEmpty) {
                  setState(() {
                    maked.Set getSet = widget.workoutInstance.sets!.last;
                    widget.workoutInstance.removeSet(getSet);
                  });
                }
              },
              icon: const LineIcon(
                LineIcons.minus,
                size: 22,
                color: Colors.red,
              ),
              label: const Text(
                "세트 삭제",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (widget.workoutInstance.sets!.isEmpty) {
                  maked.Set newSet = maked.Set(
                    setIndex: widget.workoutInstance.sets!.length,
                  );
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                } else {
                  maked.Set newSet = widget.workoutInstance.sets!.last;
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                }
              },
              icon: LineIcon(
                LineIcons.plus,
                size: 22,
                color: palette.cardColorYelGreen,
              ),
              label: Text(
                "세트 추가",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SetsDetail extends StatefulWidget {
  final int index;
  final maked.Set setInstance;
  const SetsDetail({
    super.key,
    required this.index,
    required this.setInstance,
  });

  @override
  State<SetsDetail> createState() => _SetsDetailState();
}

class _SetsDetailState extends State<SetsDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "${widget.index + 1}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: palette.cardColorWhite,
            ),
          ),
        ),
        const Expanded(
          flex: 2,
          child: SetInputField(),
        ),
        const SizedBox(
          width: 8,
        ),
        const Expanded(
          flex: 2,
          child: SetInputField(),
        ),
        const SizedBox(
          width: 8,
        ),
        const Expanded(
          flex: 2,
          child: SetInputField(),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: () {
              if (widget.setInstance.setComplete == false) {
                setState(() {
                  widget.setInstance.setComplete = true;
                });
              } else {
                setState(() {
                  widget.setInstance.setComplete = false;
                });
              }
            },
            icon: LineIcon(
              widget.setInstance.setComplete
                  ? LineIcons.checkCircle
                  : LineIcons.circle,
              size: 30,
              color: widget.setInstance.setComplete
                  ? palette.cardColorYelGreen
                  : palette.cardColorGray,
            ),
          ),
        ),
      ],
    );
  }
}

class SetInputField extends StatelessWidget {
  const SetInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField2(
      height: 45,
      valid: false,
      textInputType: TextInputType.number,
      textStyle: TextStyle(
        color: palette.cardColorWhite,
      ),
    );
  }
}
