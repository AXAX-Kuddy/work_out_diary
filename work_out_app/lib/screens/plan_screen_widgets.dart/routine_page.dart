import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/week_in_dayli_page.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  var userProgram = [];

  void addWeeks() {
    setState(() {
      userProgram.add(
        {
          "${userProgram.length + 1}주차": [],
        },
      );
    });
  }

  void deleteWeek(index) {
    if (userProgram.isNotEmpty && index < userProgram.length) {
      setState(() {
        userProgram.removeAt(index);
      });
      for (int i = index; i < userProgram.length; i++) {
        var week = userProgram[i];
        var oldKey = week.keys.first;
        var newKey = "${i + 1}주차";
        var workouts = week[oldKey];

        userProgram[i] = {newKey: workouts};
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProgram = context.watch<provider.UserProgramListStore>().program; //provider에 저장함
  }

  @override
  Widget build(BuildContext context) {

    return BasePage(
      children: [
        WidgetsBox(
          backgroundColor: palette.bgColor,
          verticalAxis: CrossAxisAlignment.center,
          inputContent: const [
            Text(
              "Create Your Program",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: userProgram.length,
            itemBuilder: (BuildContext context, int index) {
              var weekly = userProgram[index].keys.first;
              return ProgramWeek(
                weekly: weekly,
                userProgram: userProgram,
                deleteWeek: deleteWeek,
                weekNum: index,
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            addWeeks();
            print(userProgram);
          },
          child: const Text("+주차 추가"),
        ),
      ],
    );
  }
}



class ProgramWeek extends StatefulWidget {
  final String weekly;
  List userProgram;
  Function deleteWeek;
  final int weekNum;
  ProgramWeek({
    super.key,
    required this.weekly,
    required this.userProgram,
    required this.deleteWeek,
    required this.weekNum,
  });

  @override
  State<ProgramWeek> createState() => _ProgramWeekState();
}

class CustomDataClass {
  final List userProgram;
  final String weekKey;
  final int weekNum;

  CustomDataClass({
    required this.userProgram,
    required this.weekKey,
    required this.weekNum,
  });
}
class _ProgramWeekState extends State<ProgramWeek> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
                      widget.weekly,
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
                        widget.deleteWeek(widget.weekNum);
                        print(widget.userProgram);
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
                      userProgram: widget.userProgram,
                      weekKey: widget.weekly,
                      weekNum: widget.weekNum,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: constraints.maxWidth,
                height: 180,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var userSelectWorkOut = context
                        .read<provider.UserProgramListStore>()
                        .userSelectWorkOut;
                    if (userSelectWorkOut.isNotEmpty) {
                      return Row(
                        children: [
                          Text(
                            "${context.read<provider.UserProgramListStore>().userSelectWorkOut[index]}",
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
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: context
                          .read<provider.UserProgramListStore>()
                          .userSelectWorkOut
                          .isEmpty
                      ? 1
                      : context
                          .read<provider.UserProgramListStore>()
                          .userSelectWorkOut
                          .length,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}


