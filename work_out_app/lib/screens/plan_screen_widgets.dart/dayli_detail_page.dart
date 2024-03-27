import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/drop_down.dart';
import 'package:work_out_app/widgets/inten_select.dart';
import 'package:work_out_app/widgets/text_field.dart';
import 'package:work_out_app/widgets/wide_button.dart';
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
  final int? dayNum;
  final List<maked.Workout>? workouts;
  final int callPlace;
  final Function? changedListner;
  const DailyDetail({
    super.key,
    this.dayNum,
    this.workouts,
    required this.callPlace,
    this.changedListner,
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
            if (widget.callPlace == 0)
              Text(
                "${widget.dayNum! + 1}일차 세부 운동 설정",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              )
            else if (widget.callPlace == 1)
              const Text(
                "금일 운동 설정",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              )
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
              maked.Workout? workout = workouts![index];

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
                        Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${workout.name}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: palette.cardColorWhite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "세트",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "중량 Kg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "횟수",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "강도",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
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
                          height: 25,
                        ),
                        Column(
                          children: List.generate(
                            workout.sets!.length,
                            (int index) {
                              return SetDetail(
                                key: ValueKey(index),
                                setIndex: index,
                                setInstance: workout.sets![index],
                                workoutInstance: workout,
                                tempoList: tempoList,
                                updateState: () {
                                  setState(() {
                                    sets;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        WideButton(
                          width: 150,
                          height: 50,
                          unTapColor: palette.bgFadeColor,
                          tapColor: palette.bgColor,
                          tapBorderColor: palette.cardColorYelGreen,
                          onTapUpFunction: () {
                            maked.Set newSet = maked.Set();
                            setState(() {
                              workout.addSet(newSet);
                            });
                          },
                          inputContent: [
                            Icon(
                              LineIcons.angleUp,
                              color: palette.cardColorWhite,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "세트 추가",
                              style: TextStyle(
                                color: palette.cardColorWhite,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        WideButton(
          unTapColor: palette.bgFadeColor,
          tapColor: palette.bgColor,
          tapBorderColor: palette.cardColorYelGreen,
          onTapUpFunction: () {
            if (widget.callPlace == 0) {
              widget.changedListner!();
              Navigator.pop(context);
            }
          },
          inputContent: [
            Text(
              "설정 완료",
              style: TextStyle(
                color: palette.cardColorWhite,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SetDetail extends StatefulWidget {
  final int setIndex;
  final maked.Set setInstance;
  final maked.Workout workoutInstance;
  final Function updateState;
  List<maked.Set>? tempoList;

  SetDetail({
    super.key,
    required this.setIndex,
    required this.setInstance,
    required this.workoutInstance,
    required this.updateState,
    this.tempoList,
  });

  @override
  State<SetDetail> createState() => _SetDetailState();
}

class _SetDetailState extends State<SetDetail> {
  late final maked.Workout _workout = widget.workoutInstance;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _1rmController = TextEditingController();
  String _selectRpe = "0";
  String _select1rmPercent = "0";

  String _weightCalResult = "";
  String _e1rmText = "";

  bool _weightValid = false;
  bool _repsValid = false;

  bool _rpeSelect = false;
  // ignore: prefer_final_fields
  bool _1rmSelect = false;

  int _selectInte = 0;

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
    widget.setInstance.setIndex = widget.setIndex;
    _weightController.text = "0";
    _repsController.text = "0";
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

  double percentage(double reps, double rpe) {
    if (rpe <= 0 || reps <= 0) {
      return 0;
    }

    if (rpe > 10) {
      rpe = 10;
    }

    if (reps < 1 || rpe < 4) {
      return 0;
    }

    if (reps == 1 && rpe == 10) {
      return 100;
    }

    var x = (10 - rpe) + (reps - 1);
    if (x >= 16) {
      return 0;
    }
    var intersection = 2.92;

    if (x <= intersection) {
      var a = 0.347619;
      var b = -4.60714;
      var c = 99.9667;
      return a * x * x + b * x + c;
    }

    var m = -2.64249;
    var b = 97.0955;
    return m * x + b;
  }

  void e1rmCal(
      {required double weight, required double reps, required double rpe}) {
    if (_weightValid && _repsValid && _rpeSelect) {
      double result = percentage(reps, rpe);
      if (result <= 0 || result.isInfinite) {
        setState(() {
          _weightCalResult = "";
          _e1rmText = "";
        });
      } else {
        double e1rm = weight / result * 100;
        if (e1rm <= 0 || e1rm.isInfinite) {
          setState(() {
            _weightCalResult = "";
            _e1rmText = "";
          });
        } else {
          setState(() {
            _weightCalResult = e1rm.toStringAsFixed(1);
            _e1rmText = "e1RM : ";
          });
        }
      }
    } else {
      setState(() {
        _weightCalResult = "";
        _e1rmText = "";
      });
    }
  }

  String rpeSelectConditionChecker(String value) {
    if (_1rmSelect == false) {
      setState(() {
        _rpeSelect = true;
        _selectRpe = value;
      });
      return value;
    } else {
      setState(() {
        _rpeSelect = false;
        _selectRpe = "0";
      });
      return "0";
    }
  }

  Widget intensityGrider(int selectValue) {
    switch (selectValue) {
      case 0:
        return const SizedBox.shrink();
      case 1:
        return CustomTextField2(
          controller: _1rmController,
          inputFormatters: [
            CurrencyFormatter(),
          ],
          height: 40,
          textStyle: TextStyle(
            color: palette.cardColorWhite,
          ),
          textInputType: TextInputType.number,
          valid: _1rmSelect,
          onChanged: (value) {
            // value가 3자리수 (999% 이상)일 경우 100으로 바꿈
            if (value.length > 4) {
              _select1rmPercent = "100";
              _1rmController.text = "100%";
              setState(() {
                _1rmSelect = true;
              });
            }
          },
          onSubmitted: (value) {
            // 입력한 값이 비었을 경우
            if (value.isEmpty) {
              _select1rmPercent = "0";
              _1rmController.text = "0%";
              setState(() {
                _1rmSelect = false;
              });
              //값이 있을 경우
            } else if (value.isNotEmpty) {
              //%가 있는지 체크하고 지움
              if (value.contains("%") && value.length > 1) {
                double asValue =
                    double.parse(value.substring(0, value.length - 1));

                // 100숫자 100이상 입력 시 100으로 바꿈
                if (asValue > 100) {
                  _select1rmPercent = "100";
                  _1rmController.text = "100%";
                  setState(() {
                    _1rmSelect = true;
                  });
                }

                // 0, 혹은 0이하일 1로 바꿈
                if (asValue <= 0) {
                  _select1rmPercent = "1";
                  _1rmController.text = "1%";
                  setState(() {
                    _1rmSelect = true;
                  });
                }

                //%만 남았을 경우
              } else if (value.contains("%") == false || value.length < 2) {
                _select1rmPercent = "0";
                _1rmController.text = "0%";
                setState(() {
                  _1rmSelect = false;
                });
              }
            }
          },
        );
      case 2:
        return CustomDropDownButton(
          height: 40,
          hint: "rpe",
          textStyle: TextStyle(
            color: palette.cardColorWhite,
          ),
          itemList: rpeList,
          itemTextStyle: TextStyle(
            color: palette.cardColorWhite,
          ),
          returnableChecker: rpeSelectConditionChecker,
          onChanged: (value) {
            e1rmCal(
              weight: double.parse(_weightController.text),
              reps: double.parse(_repsController.text),
              rpe: double.parse(_selectRpe),
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${widget.setInstance.setIndex! + 1}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.cardColorWhite,
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomTextField2(
                controller: _weightController,
                height: 40,
                valid: _weightValid,
                textInputType: TextInputType.number,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
                onSubmitted: (value) {
                  double asValue = 0;
                  if (value.isNotEmpty) {
                    asValue = double.parse(value);
                  }
                  if (asValue >= 1) {
                    setState(() {
                      _weightController.text = value;
                      _weightValid = true;
                    });
                    e1rmCal(
                      weight: double.parse(_weightController.text),
                      reps: double.parse(_repsController.text),
                      rpe: double.parse(_selectRpe),
                    );
                  } else if (asValue == 0) {
                    setState(
                      () {
                        _weightController.text = "0";
                        _weightValid = false;
                      },
                    );
                    e1rmCal(
                      weight: double.parse(_weightController.text),
                      reps: double.parse(_repsController.text),
                      rpe: double.parse(_selectRpe),
                    );
                  }
                },
                onTap: () {
                  if (_weightController.text.isNotEmpty) {
                    if (double.parse(_weightController.text) <= 0) {
                      setState(() {
                        _weightController.text = "";
                        _weightValid = false;
                      });
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: CustomTextField2(
                controller: _repsController,
                height: 40,
                valid: _repsValid,
                textInputType: TextInputType.number,
                textStyle: TextStyle(
                  color: palette.cardColorWhite,
                ),
                onSubmitted: (value) {
                  double asValue = 0;
                  if (value.isNotEmpty) {
                    asValue = double.parse(value);
                  }
                  if (asValue >= 1) {
                    setState(() {
                      _repsController.text = value;
                      _repsValid = true;
                    });
                    e1rmCal(
                      weight: double.parse(_weightController.text),
                      reps: double.parse(_repsController.text),
                      rpe: double.parse(_selectRpe),
                    );
                  } else if (asValue == 0) {
                    setState(() {
                      _repsController.text = "0";
                      _repsValid = false;
                    });
                    e1rmCal(
                      weight: double.parse(_weightController.text),
                      reps: double.parse(_repsController.text),
                      rpe: double.parse(_selectRpe),
                    );
                  }
                },
                onTap: () {
                  if (_repsController.text.isNotEmpty) {
                    if (double.parse(_repsController.text) <= 0) {
                      setState(() {
                        _repsController.text = "";
                        _repsValid = false;
                      });
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: intensityGrider(_selectInte),
            ),
            Expanded(
              flex: 1,
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
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                _e1rmText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.cardColorWhite.withOpacity(0.6),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                _weightCalResult,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.cardColorWhite.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Expanded(
              flex: 2,
              child: SizedBox.shrink(),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: IntensitySelector(
                height: 30,
                hint: "강도 기반",
                textStyle: TextStyle(
                  fontSize: 12,
                  color: palette.cardColorWhite,
                ),
                itemTextStyle: TextStyle(
                  fontSize: 12,
                  color: palette.cardColorWhite,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectInte = value!;
                    intensityGrider(_selectInte);
                  });
                },
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 새로운 값이 비어있거나, 이미 '%'로 끝나는 경우, 변경 없이 반환
    if (newValue.text.isEmpty || newValue.text.endsWith('%')) {
      return newValue;
    }
    // 숫자만 입력받고, 입력된 숫자 뒤에 '%'를 붙임
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final newText = '$digitsOnly%';

    return TextEditingValue(
      text: newText,
      // 사용자가 입력을 계속할 수 있도록 커서 위치를 조정
      selection: TextSelection.collapsed(offset: newText.length - 1),
    );
  }
}
