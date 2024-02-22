import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
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
  var weekNum = 1;

  @override
  Widget build(BuildContext context) {
    var userProgramList =
        context.watch<provider.UserProgramListStore>().userSelectWorkOut;

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
            itemCount: weekNum,
            itemBuilder: (BuildContext context, int index) {
              return ProgramWeek(weekNum: index);
            },
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) {
                return const SelectWorkOut();
              })),
            );
          },
          child: const Text("+운동 추가"),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              weekNum += 1;
            });
          },
          child: const Text("+주차 추가"),
        ),
      ],
    );
  }
}

class ProgramWeek extends StatefulWidget {
  int weekNum;
  ProgramWeek({
    super.key,
    required this.weekNum,
  });

  @override
  State<ProgramWeek> createState() => _ProgramWeekState();
}

class _ProgramWeekState extends State<ProgramWeek> {
  @override
  Widget build(BuildContext context) {
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
                    "${widget.weekNum + 1}주차",
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
                      setState(() {
                        widget.weekNum -= 1;
                      });
                      print("쓰레기통");
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
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text(
                      "${context.read<provider.UserProgramListStore>().userSelectWorkOut[index]}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: context
                  .read<provider.UserProgramListStore>()
                  .userSelectWorkOut
                  .length,
            ),
          ),
        ],
      ),
    );
  }
}
