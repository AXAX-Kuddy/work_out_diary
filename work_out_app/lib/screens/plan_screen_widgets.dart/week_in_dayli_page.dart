import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/dayli_detail_page.dart';
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

  const DayliPage({
    super.key,
    required this.userProgram,
    required this.weekNum,
  });

  @override
  State<DayliPage> createState() => _DayliPageState();
}

class _DayliPageState extends State<DayliPage> {
  var dayliNum = 0;
  var dayliWorkouts;
  var weekInstance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var programInstance = context
        .read<provider.UserProgramListStore>()
        .getProgram(widget.weekNum);
    weekInstance = programInstance.getWeek(widget.weekNum);
    dayliWorkouts = weekInstance.days;
  }

  void addDayli(int index) {
    setState(() {
      provider.Day newDay = provider.Day(
        dayIndex: index,
      );
      weekInstance.addDay(newDay);
    });
  }

  void deleteDay(int index) {
    if (dayliWorkouts.isNotEmpty && index < dayliWorkouts.length) {
      var day = weekInstance.getDay(index);
      setState(() {
        weekInstance.removeDay(day);
      });
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
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyDetail(
                            dayNum: index,
                            workouts: dayliWorkouts,
                          ),
                        ),
                      );
                    },
                    child: WidgetsBox(
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
                                    "${index + 1}일차",
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
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (dayliWorkouts.isEmpty) {
                                      return TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) {
                                              return SelectWorkOut(
                                                workouts: dayliWorkouts,
                                                onWorkoutChanged: () {},
                                              );
                                            })),
                                          );
                                          print(dayliWorkouts);
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
                                        "${dayliWorkouts[index]}",
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
                                  deleteDay(index);
                                },
                                child: const Text(
                                  "일차 삭제하기",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addDayli(dayliWorkouts.length + 1);
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
