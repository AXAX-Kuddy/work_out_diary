import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/top_divider.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/widgets/buttons/cancel_and_enter_buttons.dart';
import 'package:work_out_app/widgets/dialog/custom_dialog.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import 'package:work_out_app/widgets/text_field/non_form_text_field.dart';
import 'package:work_out_app/provider/store.dart' as provider;

class WorkoutDetail extends StatefulWidget {
  final int index;
  final void Function(maked.Workout) removeWorkout;
  final maked.Workout workoutInstance;
  final DetailPanelController workoutDetailPanelController;

  const WorkoutDetail({
    super.key,
    required this.index,
    required this.removeWorkout,
    required this.workoutInstance,
    required this.workoutDetailPanelController,
  });

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  late provider.RoutineProvider routineProvider;
  late List<maked.WorkoutSet> setList;

  String e1rm = "";
  String e1rmWithSet = "";
  String target = "Target";
  final List<String> rpeList = [
    "5.0",
    "5.5",
    "6.0",
    "6.5",
    "7.0",
    "7.5",
    "8.0",
    "8.5",
    "9.0",
    "9.5",
    "10.0"
  ];

  void findE1rm() {
    if (setList.isNotEmpty) {
      maked.WorkoutSet maxE1rmSet = setList[0];
      for (maked.WorkoutSet set in setList) {
        if (set.e1rm > maxE1rmSet.e1rm) {
          maxE1rmSet = set;
        }
      }
      int setIndex = maxE1rmSet.setIndex! + 1;

      if (widget.workoutInstance.showE1rm == false) {
        setState(() {
          e1rmWithSet = "";
          e1rm = "";
        });
      } else {
        setState(() {
          e1rmWithSet = setIndex.toString();
          e1rm = maxE1rmSet.e1rm.toStringAsFixed(1);
        });
      }
    } else {
      setState(() {
        e1rmWithSet = "";
        e1rm = "";
      });
      print(e1rm);
    }
  }

  @override
  void initState() {
    routineProvider = context.read<provider.RoutineProvider>();
    setList = widget.workoutInstance.sets!;

    if (widget.workoutInstance.targetRpe != 0) {
      target = widget.workoutInstance.targetRpe.toString();
    }
    findE1rm();
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
              style: const TextStyle(
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
              style: const TextStyle(
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
                    return CustomDialog(
                      backgroundColor: palette.bgColor,
                      children: [
                        const Text(
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
                          textStyle: const TextStyle(
                            color: palette.cardColorWhite,
                          ),
                          itemList: rpeList,
                          itemTextStyle: const TextStyle(
                            color: palette.cardColorWhite,
                          ),
                          onChanged: (value) {
                            selectRpe = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CancelAndEnterButton(
                          cancelLabel: const Text(
                            "초기화",
                            style: TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                          onCancelTap: () {
                            setState(() {
                              selectRpe = "0";
                              target = "Target";
                              widget.workoutInstance
                                  .editTargetRpe(double.parse(selectRpe));
                            });
                            Navigator.pop(context);
                          },
                          enterLabel: const Text(
                            "확인",
                            style: TextStyle(
                              color: palette.cardColorYelGreen,
                            ),
                          ),
                          onEnterTap: () {
                            if (selectRpe == "0") {
                              setState(() {
                                widget.workoutInstance
                                    .editTargetRpe(double.parse(selectRpe));
                                target = "Target";
                              });
                            } else {
                              setState(() {
                                widget.workoutInstance
                                    .editTargetRpe(double.parse(selectRpe));
                                target = selectRpe;
                              });
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Text(
                    "@$target",
                    style: const TextStyle(
                      fontSize: 16,
                      color: palette.cardColorWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const LineIcon(
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
                widget.workoutDetailPanelController(
                  command: PanelControllerCommand.spread,
                  isCallLocation: CallPanelFrom.detail,
                  workoutInstance: widget.workoutInstance,
                  workoutInstanceIndex: widget.index,
                );
              },
              icon: const LineIcon(
                color: palette.cardColorWhite,
                size: 30,
                LineIcons.verticalEllipsis,
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
                    workoutInstance: widget.workoutInstance,
                    setInstance: widget.workoutInstance.sets![index],
                    rpeList: rpeList,
                    findE1rm: findE1rm,
                    panelController: widget.workoutDetailPanelController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Visibility(
              visible:
                  double.tryParse(e1rm) == null || double.tryParse(e1rm) == 0
                      ? false
                      : true,
              child: Text(
                "$e1rmWithSet세트 기준, e1RM : $e1rm",
                style: TextStyle(
                  color: palette.cardColorWhite.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                if (widget.workoutInstance.sets!.isNotEmpty) {
                  setState(() {
                    maked.WorkoutSet getSet = widget.workoutInstance.sets!.last;
                    widget.workoutInstance.removeSet(getSet);
                  });
                }
                findE1rm();
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
                  maked.WorkoutSet newSet = maked.WorkoutSet(
                    setIndex: widget.workoutInstance.sets!.length,
                  );
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                } else {
                  double preSetWeight =
                      widget.workoutInstance.sets!.last.weight;
                  int preSetReps = widget.workoutInstance.sets!.last.reps;

                  maked.WorkoutSet newSet = maked.WorkoutSet(
                    setIndex: widget.workoutInstance.sets!.length,
                    weight: preSetWeight,
                    reps: preSetReps,
                  );
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                }
                findE1rm();
              },
              icon: const LineIcon(
                LineIcons.plus,
                size: 22,
                color: palette.cardColorYelGreen,
              ),
              label: const Text(
                "세트 추가",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class SetsDetail extends StatefulWidget {
  final int index;
  final maked.Workout workoutInstance;
  final maked.WorkoutSet setInstance;
  final List<String>? rpeList;
  final Function findE1rm;

  final DetailPanelController panelController;

  const SetsDetail({
    super.key,
    required this.panelController,
    required this.index,
    required this.setInstance,
    required this.workoutInstance,
    this.rpeList,
    required this.findE1rm,
  });

  @override
  State<SetsDetail> createState() => _SetsDetailState();
}

class _SetsDetailState extends State<SetsDetail> {
  late provider.RoutineProvider routineProvider;
  late String? nowValue;

  String handleWeightSubmitted(String value) {
    //숫자 이외의 다른 값이 있을 경우
    if (double.tryParse(value) == null) {
      value = "0";

      widget.setInstance.editWeight(double.parse(value));

      return value;
    } else if (double.parse(value) <= 0) {
      value = "0";
      widget.setInstance.editWeight(double.parse(value));

      return value;
    }

    //끝이 .으로 끝날 경우
    if (value.endsWith(".")) {
      value += "0"; // 뒤에 0 붙임

      widget.setInstance.editWeight(double.parse(value));

      return value;
    }

    widget.setInstance.editWeight(double.parse(value));

    return value;
  }

  String handleRepsSubmitted(String value) {
    //숫자 이외의 다른 값이 있을 경우
    if (int.tryParse(value) == null) {
      value = "0";
      widget.setInstance.editReps(int.parse(value));

      return value;
    } else if (int.parse(value) <= 0) {
      value = "0";
      widget.setInstance.editReps(int.parse(value));

      return value;
    }

    //끝이 .으로 끝날 경우
    if (value.endsWith(".")) {
      value.substring(0, value.length - 1); // 소숫점 제거
      widget.setInstance.editReps(int.parse(value));

      return value;
    }
    widget.setInstance.editReps(int.parse(value));

    return value;
  }

  String handleWeightFocusout(String value) {
    if (double.tryParse(value) == null || double.tryParse(value)! <= 0) {
      value = "0";
      widget.setInstance.editWeight(double.parse(value));
      return value;
    }
    widget.setInstance.editWeight(double.parse(value));
    return value;
  }

  String handleRepsFocusout(String value) {
    if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
      value = "0";
      widget.setInstance.editReps(int.parse(value));
      return value;
    }
    widget.setInstance.editReps(int.parse(value));
    return value;
  }

  @override
  void initState() {
    super.initState();
    widget.setInstance.onUpdate = () => widget.findE1rm();

    if (widget.setInstance.rpe < 5.0) {
      nowValue = null;
    } else {
      nowValue = widget.setInstance.rpe.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.watch<provider.RoutineProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              widget.panelController(
                command: PanelControllerCommand.spread,
                isCallLocation: CallPanelFrom.sets,
                workoutInstance: widget.workoutInstance,
                workoutInstanceWeight: widget.setInstance.weight,
              );
            },
            child: Text(
              "${widget.index + 1}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: palette.cardColorWhite,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,

          //중량
          child: SetInputField(
            setInstance: widget.setInstance,
            fieldText: widget.setInstance.weight.toString(),
            onSubmitted: handleWeightSubmitted,
            onFocusout: handleWeightFocusout,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,

          // 갯수
          child: SetInputField(
            setInstance: widget.setInstance,
            fieldText: widget.setInstance.reps.toString(),
            onSubmitted: handleRepsSubmitted,
            onFocusout: handleRepsFocusout,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: CustomDropDownButton(
            enabledValid: false,
            height: 40,
            hint: "@",
            textStyle: const TextStyle(color: palette.cardColorWhite),
            nowValue: nowValue,
            itemList: widget.rpeList!,
            itemTextStyle: const TextStyle(
              color: palette.cardColorWhite,
            ),
            onChanged: (value) {
              widget.setInstance.editRpe(double.parse(value!));
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: () {
              routineProvider.onStartedRestTimer();

              if (widget.setInstance.setComplete == false) {
                widget.setInstance.changedSetComp(true);
              } else {
                widget.setInstance.changedSetComp(false);
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

class SetInputField extends StatefulWidget {
  final maked.WorkoutSet setInstance;
  final String fieldText;
  final String Function(String)? onSubmitted;
  final void Function()? onTap;
  final String Function(String)? onFocusout;

  const SetInputField({
    super.key,
    required this.setInstance,
    required this.fieldText,
    this.onSubmitted,
    this.onTap,
    this.onFocusout,
  });

  @override
  State<SetInputField> createState() => _SetInputFieldState();
}

class _SetInputFieldState extends State<SetInputField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.fieldText;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField2(
      controller: controller,
      height: 40,
      valid: false,
      textInputType: TextInputType.number,
      textStyle: const TextStyle(
        color: palette.cardColorWhite,
      ),
      onSubmitted: (value) {
        if (widget.onSubmitted != null) {
          controller.text = widget.onSubmitted!.call(value);
        }
      },
      onTap: () {
        if (double.tryParse(controller.text) == null) {
          controller.text = "";
          return;
        }
        if (double.parse(controller.text) <= 0) {
          controller.text = "";
          return;
        }
        if (widget.onTap != null) {
          widget.onTap?.call();
          return;
        }
      },
      onFocusout: (value) {
        if (widget.onFocusout != null) {
          return widget.onFocusout!.call(value);
        }
        return "0";
      },
    );
  }
}
