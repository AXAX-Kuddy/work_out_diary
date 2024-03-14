import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/week_in_dayli_page.dart';
import 'package:work_out_app/test.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/make_program.dart' as maked;

class RoutinePage extends StatefulWidget {
  final programInstance;

  const RoutinePage({
    super.key,
    required this.programInstance,
  });

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  late List<maked.Week> weeks;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    weeks = widget.programInstance.weeks;
  }

  void addWeeks(int index) {
    setState(() {
      maked.Week newWeek = maked.Week(
        weekIndex: index,
      );
      widget.programInstance.addWeek(newWeek);
    });
  }

  void deleteWeek(int index) {
    if (weeks.isNotEmpty && index < weeks.length) {
      setState(() {
        weeks.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: [
            Text(
              "${widget.programInstance.programName}",
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
            itemCount: weeks.length,
            itemBuilder: (BuildContext context, int index) {
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                maked.Week week = weeks[index];
                List<maked.Day>? days = week.days;
                return SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      WidgetsBox(
                        backgroundColor: palette.bgColor,
                        horizontalAxis: MainAxisAlignment.start,
                        height: 70,
                        inputContent: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${index + 1}주차",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteWeek(index);
                                },
                                icon: const Icon(
                                  LineIcons.trash,
                                ),
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DayliPage(
                                programInstance: widget.programInstance,
                                weeks: weeks,
                                weekNum: index,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: 180,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: days!.isEmpty ? 1 : days.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (days.isNotEmpty) {
                                maked.Day day = week.getDay(index);
                                return Row(
                                  children: [
                                    Text(
                                      "${day.dayIndex + 1}일차",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return const Row(
                                  children: [
                                    Text(
                                      "여기를 터치해서 일차를 추가해주세요!",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addWeeks(weeks.length);
            print(weeks);
          },
          child: const Text("+주차 추가"),
        ),
      ],
    );
  }
}
