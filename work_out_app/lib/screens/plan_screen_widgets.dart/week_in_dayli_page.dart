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
  var programInstance;
  final List weeks;
  final int weekNum;

  DayliPage({
    super.key,
    required this.weeks,
    required this.weekNum,
    required this.programInstance,
  });

  @override
  State<DayliPage> createState() => _DayliPageState();
}

class _DayliPageState extends State<DayliPage> {
  var dayliNum = 0;
  var day;
  var weekInstance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    weekInstance = widget.programInstance.getWeek(widget.weekNum);
    day = weekInstance.days;
  }

  void addDay(int index) {
    setState(() {
      maked.Day newDay = maked.Day(
        dayIndex: index,
      );
      weekInstance.addDay(newDay);
    });
  }

  void deleteDay(int index) {
    if (day.isNotEmpty && index < day.length) {
      var getDay = weekInstance.getDay(index);
      setState(() {
        weekInstance.removeDay(getDay);
      });
    }
  }

  void changedListner() {
    setState(() {
      day;
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
            itemCount: day.length,
            itemBuilder: (BuildContext context, int index) {
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
                                itemCount: day[widget.weekNum].workouts.isEmpty
                                    ? 1
                                    : day[widget.weekNum].workouts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (day[widget.weekNum].workouts.isEmpty) {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) {
                                            return SelectWorkOut(
                                              changedListner: changedListner,
                                              dayNum: index,
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
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DailyDetail(
                                              dayNum: index,
                                              workouts:
                                                  day[widget.weekNum].workouts,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        day[widget.weekNum]
                                            .workouts[index]
                                            .name,
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
                  );
                },
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addDay(day.length);
          },
          child: const Text(
            "일차 추가하기",
          ),
        )
      ],
    );
  }
}
