import 'package:flutter/foundation.dart';
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
import 'package:work_out_app/widgets/work_out_library/widgets/workout_list_viewer.dart';

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
  final int? exchangedWorkoutIndex;
  final void Function()? changedListner;
  const WorkoutLibrary({
    super.key,
    required this.showAddPlanningScreen,
    this.exchangedWorkoutIndex,
    this.changedListner,
  });

  @override
  State<WorkoutLibrary> createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState extends State<WorkoutLibrary> {
  late provider.RoutineProvider routineProvider;

  late Map<WorkoutListKeys, List<provider.WorkoutMenu>> workoutList;
  final List<WorkoutListKeys> keys = WorkoutListKeys.values;

  List<provider.WorkoutMenu> tempoList = [];
  List<provider.WorkoutMenu> allWorkoutList = [];

  String searchText = "";

  late Widget addWorkoutToPlanScreenButton = const SizedBox.shrink();
  maked.Workout? selectExchangeWorkout;

  late Widget tempoListViewer = const SizedBox.shrink();

  ///커맨드 1 = 추가
  ///커맨드 0 = 제거
  void managementTempoList(
      {required provider.WorkoutMenu workout, required int command}) {
    if (command == 1) {
      setState(() {
        tempoList.add(workout);
      });
      debugPrint("$tempoList");
    } else if (command == 0) {
      setState(() {
        tempoList.remove(workout);
      });
      debugPrint("$tempoList");
    } else {
      Exception("커맨드 잘못 입력함");
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

  void handleChangedAllWorkoutList() {
    setState(() {
      allWorkoutList;
    });
  }

  void changedSearchText(String value) {
    setState(() {
      searchText = value;
    });
  }

  void handleSelectExchangeWorkout({
    maked.Workout? selectWorkout,
  }) {
    if (selectWorkout != null) {
      setState(() {
        selectExchangeWorkout = selectWorkout;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    workoutList = context.read<provider.WorkoutListStore>().workouts;

    for (var workout in workoutList.values) {
      allWorkoutList.addAll(workout);
    }

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
        title: SearchWorkout(
          handleChangedPart: handleChangedPart,
          allWorkoutList: allWorkoutList,
          changedSearchText: changedSearchText,
        ),
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
        Divider(
          thickness: 0.5,
          height: 0.0,
          color: palette.cardColorWhite,
        ),
        Expanded(
          child: [
            WorkoutList(
              items: workoutList[keys[0]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutList(
              items: workoutList[keys[1]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutList(
              items: workoutList[keys[2]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutList(
              items: workoutList[keys[3]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutList(
              items: workoutList[keys[4]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutList(
              items: workoutList[keys[5]]!,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
            WorkoutListAll(
              searchText: searchText,
              allWorkoutList: allWorkoutList,
              tempoList: tempoList,
              managementTempoList: managementTempoList,
              exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
              handleSelectExchangeWorkout: handleSelectExchangeWorkout,
            ),
          ][ChangePart.index],
        ),
        // tempoListViewer,
        widget.showAddPlanningScreen
            ? WorkoutListViewer(
                list: tempoList,
                managementTempoList: managementTempoList,
              )
            : const SizedBox.shrink(),
        addWorkoutToPlanScreenButton,
      ],
    );
  }
}

class WorkoutListAll extends StatefulWidget {
  final String searchText;

  final List<provider.WorkoutMenu> allWorkoutList;
  final List<provider.WorkoutMenu> tempoList;
  final void Function(
      {required provider.WorkoutMenu workout,
      required int command}) managementTempoList;
  final void Function({maked.Workout? selectWorkout})?
      handleSelectExchangeWorkout;
  final int? exchangedWorkoutIndex;

  const WorkoutListAll({
    super.key,
    required this.searchText,
    required this.allWorkoutList,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
    this.handleSelectExchangeWorkout,
  });

  @override
  State<WorkoutListAll> createState() => _WorkoutListAllState();
}

class _WorkoutListAllState extends State<WorkoutListAll> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.allWorkoutList.length,
      itemBuilder: (context, index) {
        var hasMatch = RegExp(widget.searchText)
            .hasMatch(widget.allWorkoutList[index].name);

        if (widget.searchText.isNotEmpty && !hasMatch) {
          return const SizedBox.shrink();
        } else {
          return SelectBox(
            key: GlobalKey(),
            menu: widget.allWorkoutList[index],
            tempoList: widget.tempoList,
            managementTempoList: widget.managementTempoList,
            exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
          );
        }
      },
    );
  }
}

class WorkoutList extends StatelessWidget {
  final List<provider.WorkoutMenu> items;
  final List<provider.WorkoutMenu> tempoList;
  final void Function(
      {required provider.WorkoutMenu workout,
      required int command}) managementTempoList;
  final int? exchangedWorkoutIndex;
  final void Function({maked.Workout? selectWorkout})?
      handleSelectExchangeWorkout;

  const WorkoutList({
    super.key,
    required this.items,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
    this.handleSelectExchangeWorkout,
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
          exchangedWorkoutIndex: exchangedWorkoutIndex,
        );
      },
    );
  }
}

class SelectBox extends StatefulWidget {
  final provider.WorkoutMenu menu;
  final List<provider.WorkoutMenu> tempoList;
  final int? exchangedWorkoutIndex;
  final void Function({maked.Workout? selectWorkout})?
      handleSelectExchangeWorkout;

  final void Function({
    required provider.WorkoutMenu workout,
    required int command,
  }) managementTempoList;

  const SelectBox({
    super.key,
    required this.menu,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
    this.handleSelectExchangeWorkout,
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
    if (widget.exchangedWorkoutIndex != null) {
      
    } else {
      if (widget.tempoList.contains(widget.menu)) {
        _checker = true;
      }
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
        if (widget.handleSelectExchangeWorkout != null) {
          maked.Workout exchangeWorkout = maked.Workout(
            name: widget.menu.name,
            showE1rm: widget.menu.showE1rm,
          );
          widget.handleSelectExchangeWorkout!(
            selectWorkout: exchangeWorkout,
          );
        } else {
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
