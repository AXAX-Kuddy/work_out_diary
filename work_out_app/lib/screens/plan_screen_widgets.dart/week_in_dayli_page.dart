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
import 'package:work_out_app/make_program.dart' as maked;

class DayliPage extends StatefulWidget {
  final maked.Week weekInstance;

  const DayliPage({
    super.key,
    required this.weekInstance,
  });

  @override
  State<DayliPage> createState() => _DayliPageState();
}

class _DayliPageState extends State<DayliPage> {
  late List<maked.Day>? days = widget.weekInstance.days;

  void addDay(int index) {
    setState(() {
      maked.Day newDay = maked.Day(
        dayIndex: index,
      );
      widget.weekInstance.addDay(newDay);
      print("추가된 일차는 : ${newDay.dayIndex}");
      print("총 일차는 : ${days!.length}");
    });
  }

  void deleteDay(maked.Day day) {
    if (days!.isNotEmpty) {
      setState(() {
        int deleteIndex = day.dayIndex;
        widget.weekInstance.removeDay(day);
        print("삭제된 일차는 : ${day.dayIndex}");

        //삭제되면 인스턴스 내 dayIndex를 다시 설정
        for (int i = 0; i < days!.length; i++) {
          if (days![i].dayIndex > deleteIndex) {
            days![i].dayIndex--;
          }
        }
        print("총 일차는 : ${days!.length}");
      });
    }
  }

  void changedListner() {
    setState(() {
      days;
    });
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
              "${widget.weekInstance.weekIndex + 1} 주차",
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
            itemCount: days!.length,
            itemBuilder: (BuildContext context, int index) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  /// 일차 인스턴스
                  maked.Day day = widget.weekInstance.days![index];

                  ///일차인스턴스 안 운동 목록
                  List<maked.Workout>? workouts = day.workouts;

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
                                  "${day.dayIndex + 1}일차",
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
                                itemCount:
                                    workouts!.isEmpty ? 1 : workouts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (workouts.isNotEmpty) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DailyDetail(
                                                dayNum: index,
                                                workouts: workouts,
                                              ),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 150,
                                          child: ListView.separated(
                                            itemCount: workouts.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                            itemBuilder: (context, index) {
                                              maked.Workout workout =
                                                  workouts[index];
                                              return Text("${workout.name}");
                                            },
                                          ),
                                        ));
                                  } else {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) {
                                            return SelectWorkOut(
                                              changedListner: changedListner,
                                              dayInstance: day,
                                            );
                                          })),
                                        );
                                      },
                                      child: Text(
                                        "여기를 눌러서 운동을 추가하세요!",
                                        style: TextStyle(
                                          color: palette.cardColorWhite,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteDay(day);
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
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addDay(days!.length);
          },
          child: const Text(
            "일차 추가하기",
          ),
        )
      ],
    );
  }
}
