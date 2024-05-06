import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/dump/routine_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
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

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  late provider.RoutineProvider routineProvider;

  late Widget restTimerWidget;
  late Widget restTimerButton;
  late TextButton workoutTimerButton;

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

    switch (routineProvider.workoutStart) {
      case true:
        workoutTimerButton = TextButton(
          onPressed: () {
            routineProvider.onWorkoutTimerStopped();
            routineProvider.setWorkoutFinish();
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
        title: GestureDetector(
          onTap: () {},
          child: const Text(
            "Planning",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                          provider.Routine.restTimer.onStartTimer();
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
