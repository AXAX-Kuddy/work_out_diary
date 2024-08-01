import 'dart:async';
import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart';
import 'package:work_out_app/main.dart';
import 'package:work_out_app/screens/diary_screen/diary_screen.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/plate_calc.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/cancel_and_enter_buttons.dart';
import 'package:work_out_app/widgets/buttons/trash_can_button.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/dialog/custom_dialog.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/sliding_up_panel/panel_button.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/select_work_out_screen.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/workout_complete.dart';
import 'package:work_out_app/screens/plan_screen/plan_screen_widgets/workout_detail.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/widgets/sliding_up_panel/sliding_up_panel.dart';
import 'package:work_out_app/widgets/work_out_library/work_out_library.dart';

typedef DetailPanelController = void Function({
  required PanelControllerCommand command,
  CallPanelFrom? isCallLocation,
  maked.Workout? workoutInstance,
  int? workoutInstanceIndex,
  double? workoutInstanceWeight,
});

enum CallPanelFrom {
  detail,
  sets,
}

class PlanningScreen extends StatefulWidget {
  final VoidCallback? onPageLoaded;
  final void Function(String children)? updateRoutine;

  const PlanningScreen({
    super.key,
    this.onPageLoaded,
    this.updateRoutine,
  });

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final AppDatabase database = AppDatabase();
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  maked.Workout panelCallingInstance = maked.Workout(
    name: "placeHold",
  );
  int? panelCallingInstanceIndex;
  double? panelCallingInstanceWeight;
  CallPanelFrom callLocation = CallPanelFrom.detail;

  String routineTitle = "";
  late provider.RoutineProvider routineProvider;

  late Widget restTimerWidget;
  late Widget restTimerButton;
  late TextButton workoutTimerButton;

  void setRoutineName() {
    String nowTime = DateTime.now().toString();
    routineTitle = "${nowTime.substring(0, 10)}일자 루틴";
  }

  void changeTitle(String value) {
    setState(() {
      routineTitle = value;
    });
  }

  void workoutComplete() async {
    List<String> jsonData = [];

    for (var workout in routineProvider.todayWorkouts) {
      jsonData.add(json.encode(workout.toJsonEncode()));
    }

    await database.into(database.routines).insert(
          RoutinesCompanion.insert(
            routineName: routineTitle,
            date: DateTime.now(),
            children: json.encode(jsonData),
          ),
        );
    if (mounted) {
      routineProvider.clearUserSelectWorkout();
      routineProvider.onDisposeWorkoutTimer();
      routineProvider.onStoppedRestTimer();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const WorkoutCompleteScreen();
      }));
    }
  }

  Future<dynamic> showRestTimerDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Consumer<provider.RoutineProvider>(
            builder: (context, routineProvider, child) {
              return Dialog(
                backgroundColor: palette.bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 100,
                    height: 360,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Switch(
                              activeColor: palette.cardColorYelGreen,
                              activeTrackColor: palette.bgFadeColor,
                              inactiveThumbColor: palette.cardColorWhite,
                              inactiveTrackColor: palette.bgColor,
                              value: routineProvider.onRest,
                              onChanged: (value) {
                                routineProvider.setRestTimer(value);
                              },
                            )
                          ],
                        ),
                        restTimerWidget,
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  void workoutDetailPanelController({
    required PanelControllerCommand command,
    CallPanelFrom? isCallLocation,
    maked.Workout? workoutInstance,
    int? workoutInstanceIndex,
    double? workoutInstanceWeight,
  }) {
    switch (command) {
      case PanelControllerCommand.spread:
        if (isCallLocation != null) {
          callLocation = isCallLocation;
        }

        if (workoutInstance != null) {
          setState(() {
            panelCallingInstance = workoutInstance;
          });
        }

        if (workoutInstanceIndex != null) {
          setState(() {
            panelCallingInstanceIndex = workoutInstanceIndex;
          });
        }

        if (workoutInstanceWeight != null) {
          setState(() {
            panelCallingInstanceWeight = workoutInstanceWeight;
          });
        }

        if (isCallLocation == CallPanelFrom.sets) {
          setState(() {
            panelController.expand();
          });
        } else {
          setState(() {
            panelController.anchor();
          });
        }

      case PanelControllerCommand.anchor:
        setState(() {
          panelController.anchor();
        });
      case PanelControllerCommand.hide:
        setState(() {
          panelController.hide();
        });
      default:
        null;
    }
  }

  List<PanelItemBuilder> panelItems(CallPanelFrom callPanelFrom) {
    switch (callPanelFrom) {
      case CallPanelFrom.sets:
        return [
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return PlateCalculator(
              weight: panelCallingInstanceWeight!,
              constraints: constraints,
            );
          }),
        ];

      default:
        return [
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return InnerPanelButton(
              constraints: constraints,
              contentText: "교체",
              icon: LineIcons.alternateExchange,
              iconColor: palette.cardColorWhite,
              onTap: () {
                workoutDetailPanelController(
                    command: PanelControllerCommand.hide);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WorkoutLibrary(
                        showAppbarCloseButton: true,
                        showAddPlanningScreen: false,
                        exchangedWorkoutIndex: panelCallingInstanceIndex,
                      );
                    },
                  ),
                );
              },
            );
          }),
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return InnerPanelButton(
              constraints: constraints,
              contentText: "삭제",
              contentTextStyle: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              icon: LineIcons.trash,
              iconColor: Colors.red,
              showAngle: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(25),
                      backgroundColor: palette.bgColor,
                      content: Text(
                        "${panelCallingInstance.name}를(을) 목록에서 삭제 하시겠습니까?",
                        style: const TextStyle(
                          fontSize: 16,
                          color: palette.cardColorWhite,
                        ),
                      ),
                      actions: [
                        CancelAndEnterButton(
                          cancelLabel: const Text(
                            "취소",
                            style: TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                          onCancelTap: () {
                            Navigator.pop(context);
                          },
                          enterLabel: const Text(
                            "확인",
                            style: TextStyle(
                              color: palette.cardColorYelGreen,
                            ),
                          ),
                          onEnterTap: () {
                            setState(() {
                              workoutDetailPanelController(
                                  command: PanelControllerCommand.hide);
                              routineProvider.removeUserSelectWorkout(
                                  panelCallingInstance);
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }),
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    setRoutineName();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onPageLoaded?.call();
    });

    context.read<provider.RoutineProvider>().loadPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.watch<provider.RoutineProvider>();

    switch (routineProvider.workoutStart) {
      case true:
        workoutTimerButton = TextButton(
          onPressed: () {
            routineProvider.onWorkoutTimerStopped();
            routineProvider.setWorkoutFinish();
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: const EdgeInsets.all(10),
                    backgroundColor: palette.bgColor,
                    child: SizedBox(
                      height: 100,
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "운동을 마치시겠습니까?",
                            style: TextStyle(
                              color: palette.cardColorWhite,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "눼니오",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  workoutComplete();
                                },
                                child: const Text(
                                  "눼",
                                  style: TextStyle(
                                    color: palette.cardColorYelGreen,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: palette.cardColorYelGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "운동 완료",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: palette.bgColor,
              ),
            ),
          ),
        );

      default:
        workoutTimerButton = TextButton(
          onPressed: () {
            routineProvider.onWorkoutTimerStart();
            routineProvider.setWorkoutStart();
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: palette.cardColorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "운동 시작",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: palette.bgColor,
              ),
            ),
          ),
        );
    }

    switch (routineProvider.onRest) {
      case true:
        routineProvider.totalRest();
        restTimerButton = RestTimeWidget(
          showRestTimerDialog: showRestTimerDialog,
        );

        restTimerWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RestTimeScrollList(
                  onSelectedItemChanged: (index) {
                    setState(() {
                      routineProvider.setRestTimeMin(index);
                    });
                  },
                  children: List.generate(
                    11,
                    (index) {
                      return Text(
                        "$index분",
                        style: const TextStyle(
                          fontSize: 14,
                          color: palette.cardColorWhite,
                        ),
                      );
                    },
                  ),
                ),
                RestTimeScrollList(
                  onSelectedItemChanged: (index) {
                    setState(() {
                      routineProvider.setRestTimeSec(index);
                    });
                  },
                  children: List.generate(
                    60,
                    (index) {
                      return Text(
                        "$index초",
                        style: const TextStyle(
                          fontSize: 14,
                          color: palette.cardColorWhite,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    routineProvider.restTimeMin.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: palette.cardColorWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(
                    fontSize: 20,
                    color: palette.cardColorWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    routineProvider.restTimeSec.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: palette.cardColorWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    routineProvider.totalRest();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "설정하기",
                    style: TextStyle(
                      color: palette.cardColorWhite,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ],
        );

      default:
        restTimerButton = TextButton(
          onPressed: () {
            showRestTimerDialog();
          },
          child: const Row(
            children: [
              Text(
                "휴식시간 설정",
                style: TextStyle(
                  fontSize: 14,
                  color: palette.cardColorWhite,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              LineIcon(
                LineIcons.clock,
                color: palette.cardColorYelGreen,
                size: 18,
              ),
            ],
          ),
        );

        restTimerWidget = const Expanded(
          child: Center(
            child: Text(
              "휴식시간을 설정하려면 버튼을 눌러주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: palette.cardColorWhite,
              ),
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const LineIcon(
              LineIcons.angleRight,
              color: palette.cardColorWhite,
              size: 30,
            )),
        title: TitleTextField(
          title: routineTitle,
          changeTitle: changeTitle,
        ),
      ),
      slidingUpPanelWidget: CustomSlidingUpPanelWidget(
        controller: panelController,
        onlyAnchor: callLocation != CallPanelFrom.sets,
        children: <PanelItemBuilder>[
          PanelItemBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    panelCallingInstance.name!,
                    style: const TextStyle(
                      color: palette.cardColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      workoutDetailPanelController(
                          command: PanelControllerCommand.hide);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              );
            },
          ),
          ...panelItems(callLocation),
        ],
      ),
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
              itemCount: routineProvider.todayWorkouts.isEmpty
                  ? 1
                  : routineProvider.todayWorkouts.length,
              itemBuilder: (BuildContext context, int index) {
                if (routineProvider.todayWorkouts.isEmpty) {
                  return const Center(
                    heightFactor: 20,
                    child: Text(
                      "운동을 추가해주세요!",
                      style: TextStyle(
                        fontSize: 20,
                        color: palette.cardColorWhite,
                      ),
                    ),
                  );
                } else {
                  return WorkoutDetail(
                    index: index,
                    workoutInstance: routineProvider.todayWorkouts[index],
                    removeWorkout: routineProvider.removeUserSelectWorkout,
                    workoutDetailPanelController: workoutDetailPanelController,
                  );
                }
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SelectWorkoutPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: const LineIcon.plus(
                  color: palette.cardColorYelGreen,
                  size: 28,
                ),
                label: const Text(
                  "운동추가",
                  style: TextStyle(
                    fontSize: 17,
                    color: palette.cardColorWhite,
                  ),
                ),
              ),
              if (routineProvider.todayWorkouts.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            width: null,
                            children: [
                              const Text(
                                "오늘 운동을 취소하고 모든 종목을 삭제하시겠어요?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: palette.cardColorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CancelAndEnterButton(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spaceWidth: 40.0,
                                cancelLabel: const Text(
                                  "아뇨!",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: palette.colorRed,
                                  ),
                                ),
                                onCancelTap: () {
                                  Navigator.pop(context);
                                },
                                enterLabel: const Text(
                                  "네😭",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: palette.cardColorYelGreen,
                                  ),
                                ),
                                onEnterTap: () {
                                  routineProvider.clearUserSelectWorkout();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: const TrashCanIcon(),
                  label: const Text(
                    "운동 취소",
                    style: TextStyle(
                      fontSize: 17,
                      color: palette.cardColorWhite,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.updateRoutine != null)
          BottomBar(
              updateRoutine: widget.updateRoutine,
              routineProvider: routineProvider,
              restTimerButton: restTimerButton,
              workoutTimerButton: workoutTimerButton)
        else
          BottomBar(
              routineProvider: routineProvider,
              restTimerButton: restTimerButton,
              workoutTimerButton: workoutTimerButton),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  final void Function(String children)? updateRoutine;

  final provider.RoutineProvider routineProvider;
  final Widget restTimerButton;
  final TextButton workoutTimerButton;

  const BottomBar({
    super.key,
    this.updateRoutine,
    required this.routineProvider,
    required this.restTimerButton,
    required this.workoutTimerButton,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: routineProvider.todayWorkouts.isNotEmpty,
      child: Container(
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: palette.bgFadeColor,
        ),
        child: updateRoutine != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: WideButtonBlack(
                        onTapUpFunction: () async {
                          List<String> jsonData = [];

                          for (var workout in routineProvider.todayWorkouts) {
                            jsonData.add(json.encode(workout.toJsonEncode()));
                          }

                          updateRoutine!.call(json.encode(jsonData));
                          SlidePage.goto(
                            context: context,
                            page: const MyApp(),
                          );
                        },
                        child: const Center(
                          child: Text(
                            "루틴 업데이트",
                            style: TextStyle(
                              fontSize: 17,
                              color: palette.cardColorWhite,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  restTimerButton,
                  WorkoutTimeWidget(
                    routineProvider: routineProvider,
                    workoutTimerButton: workoutTimerButton,
                  ),
                ],
              ),
      ),
    );
  }
}

class TitleTextField extends StatefulWidget {
  final String title;
  final Function(String) changeTitle;

  const TitleTextField({
    super.key,
    required this.title,
    required this.changeTitle,
  });

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late String title = "${widget.title}일자 루틴";

  @override
  void initState() {
    super.initState();
    _controller.text = title;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        return;
      } else {
        _controller.text = title;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: palette.cardColorYelGreen,
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        widget.changeTitle(value);
      },
      onSubmitted: (value) {
        if (value.isEmpty) {
          _controller.text = title;
          widget.changeTitle(title);
        }
        widget.changeTitle(value);
      },
      style: const TextStyle(
        fontSize: 18,
        color: palette.cardColorWhite,
      ),
      decoration: const InputDecoration(
        focusColor: palette.cardColorYelGreen,
        prefixIcon: LineIcon(
          LineIcons.pen,
          size: 25,
        ),
        prefixIconColor: palette.cardColorYelGreen,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: palette.cardColorYelGreen,
          ),
        ),
      ),
    );
  }
}

class WorkoutTimeWidget extends StatelessWidget {
  final provider.RoutineProvider routineProvider;
  final TextButton workoutTimerButton;

  const WorkoutTimeWidget({
    super.key,
    required this.routineProvider,
    required this.workoutTimerButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder(
          stream: provider.Routine.stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snapshot) {
            final value = snapshot.data;
            final displayTime = StopWatchTimer.getDisplayTime(
              value!,
              milliSecond: false,
            );
            return Row(
              children: [
                Text(
                  displayTime,
                  style: const TextStyle(
                    fontSize: 18,
                    color: palette.cardColorWhite,
                  ),
                ),
                workoutTimerButton,
              ],
            );
          },
        ),
      ],
    );
  }
}

class RestTimeWidget extends StatefulWidget {
  final Future<dynamic> Function() showRestTimerDialog;

  const RestTimeWidget({
    super.key,
    required this.showRestTimerDialog,
  });

  @override
  State<RestTimeWidget> createState() => _RestTimeWidgetState();
}

class _RestTimeWidgetState extends State<RestTimeWidget> {
  late provider.RoutineProvider routineProvider;

  Color _changedTimerColor(int time) {
    if (time < 5000) {
      return Colors.red;
    } else {
      return palette.cardColorWhite;
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
      children: [
        StreamBuilder(
          stream: provider.Routine.restTimer.rawTime,
          initialData: 0,
          builder: (context, snapshot) {
            final value = snapshot.data as int;
            final displayTime = StopWatchTimer.getDisplayTime(
              value,
              hours: false,
              milliSecond: false,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value <= 100) {
                routineProvider.resetRestSnackbarShown();
              }

              if (routineProvider.onRestStart &&
                  !routineProvider.hasShowSnackbar) {
                if (value <= 6000 && value >= 200) {
                  AnimatedSnackBar(
                    builder: ((context) {
                      return const MaterialAnimatedSnackBar(
                        titleText: "곧 휴식시간이 종료됩니다!",
                        messageText: '다음 세트에 돌입할 준비를 하세요!',
                        type: AnimatedSnackBarType.info,
                        backgroundColor: palette.cardColorYelGreen,
                        foregroundColor: palette.bgColor,
                        titleTextStyle: TextStyle(
                          color: palette.bgColor,
                        ),
                      );
                    }),
                  ).show(context);

                  routineProvider.setRestSnackbarState(true);
                }
              }
            });

            return GestureDetector(
              onTap: () {
                widget.showRestTimerDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      displayTime,
                      style: TextStyle(
                        fontSize: 18,
                        color: _changedTimerColor(value),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          routineProvider.onStartedRestTimer();
                        },
                        icon: const LineIcon(
                          LineIcons.angleDoubleRight,
                          color: palette.cardColorYelGreen,
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class RestTimeScrollList extends StatefulWidget {
  final double width;
  final double height;
  final List<Widget> children;
  final void Function(int)? onSelectedItemChanged;

  const RestTimeScrollList({
    super.key,
    this.width = 90,
    this.height = 140,
    required this.children,
    this.onSelectedItemChanged,
  });

  @override
  State<RestTimeScrollList> createState() => _RestTimeScrollListState();
}

class _RestTimeScrollListState extends State<RestTimeScrollList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
        color: palette.cardColorYelGreen,
      ))),
      child: ListWheelScrollView(
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: widget.onSelectedItemChanged,
        useMagnifier: true,
        magnification: 1.2,
        itemExtent: 40,
        children: widget.children,
      ),
    );
  }
}
