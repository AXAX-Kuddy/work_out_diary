import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:go_router/go_router.dart';

class DayliPage extends StatefulWidget {
  final List userProgram;
  final int weekNum;
  final String weekKey;

  const DayliPage({
    super.key,
    required this.userProgram,
    required this.weekNum,
    required this.weekKey,
  });

  @override
  State<DayliPage> createState() => _DayliPageState();
}

class _DayliPageState extends State<DayliPage> {
  var dayliNum = 0;
  late List dayliWorkouts;

  @override
  void initState() {
    super.initState();
    dayliWorkouts = widget.userProgram[widget.weekNum][widget.weekKey];
  }

  void addDayli() {
    setState(() {
      dayliWorkouts.add({"${dayliWorkouts.length + 1}일차": []});
    });
  }

  void deleteDay(index) {
    if (dayliWorkouts.isNotEmpty && index < dayliWorkouts.length) {
      setState(() {
        dayliWorkouts.removeAt(index);
      });

      for (int i = index; i < dayliWorkouts.length; i++) {
        var dayli = dayliWorkouts[i];
        var oldKey = dayli.keys.first;
        var newKey = "${i + 1}일차";
        var workouts = dayli[oldKey];

        dayliWorkouts[i] = {newKey: workouts};
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          height: 60,
          inputContent: [
            Text(
              "${widget.weekNum + 1} 주차",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dayliWorkouts.length,
            itemBuilder: (BuildContext context, int index) {
              var dayliKey = dayliWorkouts[index].keys.first;
              var workouts = dayliWorkouts[index][dayliKey];
              var dayNum = index;
              return DayliRoutine(
                dayli: dayliKey,
                deleteDay: deleteDay,
                workouts: workouts,
                dayNum: dayNum,
                userProgram: widget.userProgram,
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addDayli();
            print(dayliWorkouts);
            print(widget.userProgram);
          },
          child: const Text(
            "일차 추가하기",
          ),
        )
      ],
    );
  }
}

class DayliRoutine extends StatefulWidget {
  final String dayli;
  final List workouts;
  final Function deleteDay;
  final int dayNum;
  final List userProgram;

  const DayliRoutine({
    super.key,
    required this.dayli,
    required this.deleteDay,
    required this.workouts,
    required this.dayNum,
    required this.userProgram,
  });

  @override
  State<DayliRoutine> createState() => _DayliRoutineState();
}

class _DayliRoutineState extends State<DayliRoutine> {

  void onWorkoutChanged(List updatedWorkouts) {
    setState(() {
      updatedWorkouts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return WidgetsBox(
          backgroundColor: palette.bgColor,
          border: Border.all(
            color: palette.cardColorGray,
          ),
          height: 250,
          inputContent: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.dayli,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: 150,
                    child: ListView.builder(
                      itemCount: widget.workouts.isNotEmpty
                          ? widget.workouts.length
                          : 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.workouts.isEmpty) {
                          return TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: ((context) {
                                  return SelectWorkOut(
                                    workouts: widget.workouts,
                                    onWorkoutChanged: onWorkoutChanged,
                                  );
                                })),
                              );
                              print(widget.workouts);
                            },
                            child: Text(
                              "여기를 눌러서 운동을 추가하세요!",
                              style: TextStyle(
                                color: palette.cardColorWhite,
                              ),
                            ),
                          );
                        } else {
                          return Text(
                            "${widget.workouts[index]}",
                            style: TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.deleteDay(widget.dayNum);
                      print(widget.userProgram);
                    },
                    child: const Text(
                      "일차 삭제하기",
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
