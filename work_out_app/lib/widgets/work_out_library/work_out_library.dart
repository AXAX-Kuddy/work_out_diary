import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/listview_of_part.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/search_of_workout.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:work_out_app/provider/make_program.dart' as maked;

class ChangePart {
  static int index = 0;

  static void changeIndex(int value) {
    index = value;
  }

  static void dispose() {
    index = 0;
  }
}

class WorkoutLibrary extends StatefulWidget {
  final bool showAddPlanningScreen;
  final void Function()? changedListner;
  const WorkoutLibrary({
    super.key,
    required this.showAddPlanningScreen,
    this.changedListner,
  });

  @override
  State<WorkoutLibrary> createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState extends State<WorkoutLibrary> {
  List<provider.WorkoutMenu> tempoList = [];
  final List<WorkoutListKeys> keys = WorkoutListKeys.values;
  late Widget addWorkoutToPlanScreenButton = const SizedBox.shrink();

  late Map<WorkoutListKeys, List<provider.WorkoutMenu>> workoutList;
  late provider.RoutineProvider routineProvider;

  void managementTempoList(
      {required provider.WorkoutMenu workout, required int command}) {
    if (command == 1) {
      tempoList.add(workout);
      debugPrint("$tempoList");
    } else if (command == 0) {
      tempoList.remove(workout);
      debugPrint("$tempoList");
    } else {
      debugPrint("커맨드가 잘못 입력됨");
    }
  }

  void disposeTempoList() {
    tempoList = [];
  }

  void handleChangedPart() {
    setState(() {
      ChangePart.index;
    });
  }

  @override
  void initState() {
    super.initState();
    workoutList = context.read<provider.WorkoutListStore>().workouts;

    if (widget.showAddPlanningScreen) {
      addWorkoutToPlanScreenButton = WideButton(
        onTapUpFunction: () {
          for (int i = 0; i < tempoList.length; i++) {
            maked.Workout selectWorkout = maked.Workout(
              name: tempoList[i].name,
              showE1rm: tempoList[i].showE1rm,
            );

            routineProvider.addUserSelectWorkout(selectWorkout);
          }
          Navigator.pop(context);
        },
        children: const [
          Text("운동 추가하기"),
        ],
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.watch<provider.RoutineProvider>();
  }

  @override
  void dispose() {
    super.dispose();
    ChangePart.dispose();
    disposeTempoList();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        centerTitle: true,
        title: const SearchWorkout(),
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
          onChanged: handleChangedPart,
          workoutList: workoutList,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: [
            WorkoutList(
              items: workoutList[keys[0]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
            WorkoutList(
              items: workoutList[keys[1]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
            WorkoutList(
              items: workoutList[keys[2]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
            WorkoutList(
              items: workoutList[keys[3]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
            WorkoutList(
              items: workoutList[keys[4]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
            WorkoutList(
              items: workoutList[keys[5]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
            ),
          ][ChangePart.index],
        ),
        addWorkoutToPlanScreenButton,
      ],
    );
  }
}

class WorkoutList extends StatelessWidget {
  final List<provider.WorkoutMenu> items;
  final List<provider.WorkoutMenu> tempoList;
  final void Function(
      {required provider.WorkoutMenu workout,
      required int command}) managementTempoList;

  const WorkoutList({
    super.key,
    required this.items,
    required this.tempoList,
    required this.managementTempoList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SelectBox(
          key: GlobalKey(),
          menu: items[index],
          tempoList: tempoList,
          managementTempoList: managementTempoList,
        );
      },
    );
  }
}

class SelectBox extends StatefulWidget {
  final provider.WorkoutMenu menu;
  final List<provider.WorkoutMenu> tempoList;

  final void Function({
    required provider.WorkoutMenu workout,
    required int command,
  }) managementTempoList;

  const SelectBox({
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

  @override
  void initState() {
    super.initState();

    if (widget.tempoList.contains(widget.menu)) {
      _checker = true;
    }
  }

  void addWorkout() {
    setState(() {
      widget.managementTempoList(
        command: 1,
        workout: widget.menu,
      );
    });
  }

  void deleteWorkout() {
    if (widget.tempoList.isNotEmpty) {
      setState(() {
        widget.managementTempoList(
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
          if (widget.tempoList.contains(widget.menu) == false) {
            setState(() {
              _checker = true;
              addWorkout();
            });
          }
        } else {
          if (widget.tempoList.contains(widget.menu)) {
            setState(() {
              _checker = false;
              deleteWorkout();
            });
          }
        }
      },
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _checker ? palette.selectColor : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: palette.cardColorWhite,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              widget.menu.name,
              style: TextStyle(
                fontSize: 18,
                color: palette.cardColorWhite,
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
