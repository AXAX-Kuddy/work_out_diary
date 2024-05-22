import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/dump/routine_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_workout/select_work_out_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/workout_complete.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/workout_detail.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/drop_down.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:work_out_app/make_program.dart' as maked;
import 'package:work_out_app/database.dart';
import 'package:drift/drift.dart' as drift;

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final AppDatabase database = AppDatabase();
  String routineName = "";
  late provider.RoutineProvider routineProvider;

  late Widget restTimerWidget;
  late Widget restTimerButton;
  late TextButton workoutTimerButton;

  void setRoutineName() {
    String nowTime = DateTime.now().toString();
    routineName = nowTime.substring(0, 10);
  }

  void changeTitle(String value) {
    setState(() {
      routineName = value;
    });
  }

  void workoutComplete() async {
    await database.into(database.routines).insert(
          RoutinesCompanion.insert(
            routineName: drift.Value(routineName),
            date: drift.Value(DateTime.now()),
          ),
        );
    for (int i = 0; i < routineProvider.todayWorkouts.length; i++) {
      final maked.Workout workoutInstance = routineProvider.todayWorkouts[i];
      final WorkoutsCompanion workoutsCompanion =
          workoutInstance.toWorkoutCompanion(workoutInstance);
      await database.insertWorkout(workoutsCompanion);

      for (int i = 0; i < workoutInstance.sets!.length; i++) {
        final maked.Set setInstance = workoutInstance.sets![i];
        final WorkoutSetsCompanion setsCompanion =
            setInstance.toSetCompanion(setInstance);
        await database.insertSet(setsCompanion);
      }
    }
    if (mounted) {
      for (int i = 0; i < routineProvider.todayWorkouts.length; i++) {
        routineProvider
            .removeUserSelectWorkout(routineProvider.todayWorkouts[i]);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const WorkoutCompleteScreem();
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.watch<provider.RoutineProvider>();
    setRoutineName();

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
                          Text(
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
                                child: Text(
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
            child: Text(
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
            child: Text(
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
                    routineProvider.setRestTimeMin(index);
                  },
                  children: List.generate(
                    11,
                    (index) {
                      return Text(
                        "$index분",
                        style: TextStyle(
                          fontSize: 14,
                          color: palette.cardColorWhite,
                        ),
                      );
                    },
                  ),
                ),
                RestTimeScrollList(
                  onSelectedItemChanged: (index) {
                    routineProvider.setRestTimeSec(index);
                  },
                  children: List.generate(
                    60,
                    (index) {
                      return Text(
                        "$index초",
                        style: TextStyle(
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
                    style: TextStyle(
                      fontSize: 20,
                      color: palette.cardColorWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
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
                    style: TextStyle(
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
                      setState(() {
                        routineProvider.totalRest();
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "설정하기",
                      style: TextStyle(
                        color: palette.cardColorWhite,
                        fontSize: 17,
                      ),
                    ))
              ],
            ),
          ],
        );

      default:
        restTimerWidget = Expanded(
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

    if (routineProvider.restTimeTotal <= 0) {
      restTimerButton = TextButton(
        onPressed: () {
          showRestTimerDialog();
        },
        child: Row(
          children: [
            Text(
              "휴식시간 설정",
              style: TextStyle(
                fontSize: 14,
                color: palette.cardColorWhite,
              ),
            ),
            const SizedBox(
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
    } else {
      restTimerButton = RestTimeWidget(
        showRestTimerDialog: showRestTimerDialog,
      );
    }
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
            icon: LineIcon(
              LineIcons.angleRight,
              color: palette.cardColorWhite,
              size: 30,
            )),
        title: TitleTextField(
          title: routineName,
          changeTitle: changeTitle,
        ),
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
                  return Center(
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
                  );
                }
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SelectWorkOut(
                      addFunction: (List<maked.Workout> selectList) {
                        for (int i = 0; i < selectList.length; i++) {
                          routineProvider.addUserSelectWorkout(selectList[i]);
                          // addWorkout(selectList[i]);
                        }
                      },
                      changedListner: () {
                        setState(() {
                          routineProvider.todayWorkouts;
                        });
                      },
                    ),
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
              icon: LineIcon.plus(
                color: palette.cardColorYelGreen,
                size: 28,
              ),
              label: Text(
                "운동추가",
                style: TextStyle(
                  fontSize: 17,
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: routineProvider.todayWorkouts.isNotEmpty,
          child: Container(
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: palette.bgFadeColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                restTimerButton,
                WorkoutTimeWidget(
                    routineProvider: routineProvider,
                    workoutTimerButton: workoutTimerButton),
              ],
            ),
          ),
        ),
      ],
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
      style: TextStyle(
        fontSize: 18,
        color: palette.cardColorWhite,
      ),
      decoration: InputDecoration(
        focusColor: palette.cardColorYelGreen,
        prefixIcon: const LineIcon(
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
                  style: TextStyle(
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

  // @override
  // void dispose() async {
  //   super.dispose();
  //   await provider.Routine.restTimer.dispose();
  // }

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
                      return MaterialAnimatedSnackBar(
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
                        icon: LineIcon(
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
      decoration: BoxDecoration(
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
