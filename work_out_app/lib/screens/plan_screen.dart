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
  late List<maked.Workout> workoutList;
  late void Function(maked.Workout) addWorkout;
  late void Function(maked.Workout) removeWorkout;
  late void Function() setWorkoutStart;
  late void Function() setWorkoutFinish;
  late StopWatchTimer stopWatchTimer;
  late bool workoutStart;
  late TextButton timerButton;

  @override
  void initState() {
    super.initState();
    workoutList = context.read<provider.UserProgramStore>().todayWorkouts;
    stopWatchTimer = context.read<provider.UserProgramStore>().stopWatchTimer;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workoutStart = context.watch<provider.UserProgramStore>().workoutStart;
    addWorkout =
        context.watch<provider.UserProgramStore>().addUserSelectWorkout;
    removeWorkout =
        context.watch<provider.UserProgramStore>().removeUserSelectWorkout;
    setWorkoutStart =
        context.watch<provider.UserProgramStore>().setWorkoutStart;
    setWorkoutFinish =
        context.watch<provider.UserProgramStore>().setWorkoutFinish;

    switch (workoutStart) {
      case true:
        timerButton = TextButton(
          onPressed: () {
            stopWatchTimer.onStopTimer();
            setWorkoutFinish();
          },
          child: const Text("운동 완료"),
        );

      default:
        timerButton = TextButton(
          onPressed: () {
            stopWatchTimer.onStartTimer();
            setWorkoutStart();
          },
          child: const Text("운동 시작"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
              itemCount: workoutList.isEmpty ? 1 : workoutList.length,
              itemBuilder: (BuildContext context, int index) {
                if (workoutList.isEmpty) {
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
                    workoutInstance: workoutList[index],
                    removeWorkout: removeWorkout,
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
                          addWorkout(selectList[i]);
                        }
                      },
                      changedListner: () {
                        setState(() {
                          workoutList;
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
          visible: workoutList.isNotEmpty,
          child: SizedBox(
            height: 50,
            child: StreamBuilder(
              stream: stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displayTime = StopWatchTimer.getDisplayTime(
                  value!,
                  milliSecond: false,
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("버튼"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          displayTime,
                          style: TextStyle(
                            color: palette.cardColorWhite,
                          ),
                        ),
                        timerButton,
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
