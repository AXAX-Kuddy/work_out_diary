import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:work_out_app/make_program.dart' as maked;

class SelectWorkOut extends StatefulWidget {
  final Function? changedListner;
  final maked.Day? dayInstance;
  final Function? addFunction;

  const SelectWorkOut({
    super.key,
    this.dayInstance,
    this.changedListner,
    this.addFunction,
  });

  @override
  State<SelectWorkOut> createState() => _SelectWorkOutState();
}

class _SelectWorkOutState extends State<SelectWorkOut> {
  List<maked.Workout> tempoList = [];

  late maked.Day? day;
  late Map<String, List<maked.Workout>> workoutList;

  void managementTempoList(
      {required maked.Workout workout, required int command}) {
    if (command == 1) {
      tempoList.add(workout);
    } else if (command == 0) {
      tempoList.remove(workout);
    } else {
      debugPrint("커맨드가 잘못 입력됨");
    }
  }

  @override
  void initState() {
    super.initState();
    day = widget.dayInstance;
    workoutList = context.read<provider.WorkoutListStore>().workouts;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: workoutList.length,
      child: BasePage(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 30,
              color: palette.cardColorWhite,
            ),
          ),
          title: Text(
            "Select Your Workout",
            style: TextStyle(
              color: palette.cardColorWhite,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Text("하체"),
              Text("등"),
              Text("가슴"),
              Text("어깨"),
              Text("이두"),
              Text("삼두"),
            ],
          ),
        ),
        children: [
          Expanded(
            child: TabBarView(children: [
              WorkoutList(
                part: "하체",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
              WorkoutList(
                part: "등",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
              WorkoutList(
                part: "가슴",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
              WorkoutList(
                part: "어깨",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
              WorkoutList(
                part: "이두",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
              WorkoutList(
                part: "삼두",
                workoutList: workoutList,
                day: day,
                tempoList: tempoList,
                managementTempoList: managementTempoList,
              ),
            ]),
          ),
          TextButton(
            onPressed: () async {
              if (widget.addFunction != null) {
                await widget.addFunction!(tempoList);
              }

              if (widget.changedListner != null) {
                widget.changedListner!();
              }
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text("운동 추가하기"),
          ),
        ],
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  final String part;
  final Map<String, List<maked.Workout>> workoutList;
  List<maked.Workout> tempoList;
  void Function({required maked.Workout workout, required int command})
      managementTempoList;

  final maked.Day? day;

  WorkoutList({
    super.key,
    required this.part,
    required this.workoutList,
    required this.day,
    required this.tempoList,
    required this.managementTempoList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: workoutList[part]!.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 20,
          color: Colors.white,
        );
      },
      itemBuilder: (context, index) {
        return SelectBox(
          // workoutName: workoutList[part]![index].name!,
          // showE1rm: workoutList[part]![index].showE1rm,
          workoutInstance: workoutList[part]![index],
          tempoList: tempoList,
          managementTempoList: managementTempoList,
        );
      },
    );
  }
}

class SelectBox extends StatefulWidget {
  // final String workoutName;
  // final bool showE1rm;
  final maked.Workout workoutInstance;
  List<maked.Workout> tempoList;

  void Function({
    required maked.Workout workout,
    required int command,
  }) managementTempoList;

  SelectBox({
    super.key,
    // required this.workoutName,
    // required this.showE1rm,
    required this.workoutInstance,
    required this.tempoList,
    required this.managementTempoList,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _checker = false;
  late maked.Day? day;
  late void Function({required maked.Workout workout, required int command})
      managementTempoList;

  @override
  void initState() {
    super.initState();
    managementTempoList = widget.managementTempoList;
  }

  void addWorkout() {
    setState(() {
      managementTempoList(
        command: 1,
        workout: widget.workoutInstance,
      );
    });
    debugPrint("${widget.tempoList}");
  }

  void deleteWorkout() {
    if (widget.tempoList.isNotEmpty) {
      setState(() {
        managementTempoList(
          command: 0,
          workout: widget.workoutInstance,
        );
      });
      debugPrint("${widget.tempoList}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_checker == false) {
          setState(() {
            _checker = true;
            addWorkout();
          });
        } else {
          setState(() {
            _checker = false;
            deleteWorkout();
          });
        }
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                _checker ? palette.cardColorYelGreen : palette.cardColorWhite,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Text(
              widget.workoutInstance.name!,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              _checker ? LineIcons.check : LineIcons.circle,
              color:
                  _checker ? palette.cardColorYelGreen : palette.cardColorWhite,
            )
          ],
        ),
      ),
    );
  }
}
