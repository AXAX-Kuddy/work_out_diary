import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_workout/page_widget/listview_of_part.dart';
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
  List<provider.WorkoutMenu> tempoList = [];

  late maked.Day? day;
  late Map<String, List<provider.WorkoutMenu>> workoutList;

  void managementTempoList(
      {required provider.WorkoutMenu workout, required int command}) {
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
    return BasePage(
      appBar: AppBar(
        centerTitle: true,
        title: const SearchBar(),
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
      ),
      children: [
        PartList(
          workoutList: workoutList,
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
    );
  }
}

class WorkoutList extends StatelessWidget {
  final String part;
  final Map<String, List<provider.WorkoutMenu>> workoutList;
  List<maked.Workout> tempoList;
  void Function({required provider.WorkoutMenu workout, required int command})
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
          menu: workoutList[part]![index],
          tempoList: tempoList,
          managementTempoList: managementTempoList,
        );
      },
    );
  }
}

class SelectBox extends StatefulWidget {
  final provider.WorkoutMenu menu;
  List<maked.Workout> tempoList;

  void Function({
    required provider.WorkoutMenu workout,
    required int command,
  }) managementTempoList;

  SelectBox({
    super.key,
    required this.menu,
    required this.tempoList,
    required this.managementTempoList,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _checker = false;
  late maked.Day? day;
  late void Function(
      {required provider.WorkoutMenu workout,
      required int command}) managementTempoList;

  @override
  void initState() {
    super.initState();
    managementTempoList = widget.managementTempoList;

    if (widget.tempoList.contains(widget.menu)) {
      _checker = true;
    }
  }

  void addWorkout() {
    setState(() {
      managementTempoList(
        command: 1,
        workout: widget.menu,
      );
    });
  }

  void deleteWorkout() {
    if (widget.tempoList.isNotEmpty) {
      setState(() {
        managementTempoList(
          command: 0,
          workout: widget.menu,
        );
      });
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
              widget.menu.name,
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
