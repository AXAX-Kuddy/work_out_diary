import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sqlite3/sqlite3.dart' as sql;
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/listview_of_part.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/search_of_workout.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;

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
    Key? key,
    required this.showAddPlanningScreen,
    this.exchangedWorkoutIndex,
    this.changedListner,
  })  : assert(
            (showAddPlanningScreen && exchangedWorkoutIndex == null) ||
                (!showAddPlanningScreen && exchangedWorkoutIndex != null),
            '서로 다른 페이지의 기능이 충돌함.'),
        super(key: key);

  @override
  State<WorkoutLibrary> createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState extends State<WorkoutLibrary> {
  db.AppDatabase database = db.AppDatabase();
  late provider.RoutineProvider routineProvider;
  late provider.WorkoutListStore workoutListStore;

  late Map<WorkoutListKeys, List<provider.WorkoutMenu>> workoutList;
  final List<WorkoutListKeys> keys = WorkoutListKeys.values;

  List<provider.WorkoutMenu> tempoList = [];
  List<provider.WorkoutMenu> allWorkoutList = [];

  String searchText = "";

  late Widget bottomAddButton = const SizedBox.shrink();
  late Widget tempoListViewer = const SizedBox.shrink();

  ///커맨드 1 = 추가
  ///커맨드 0 = 제거
  void managementTempoList(
      {provider.WorkoutMenu? workout, required int command}) {
    assert(
        (command == 0 && workout != null) ||
            (command == 1 && workout != null) ||
            command == 2,
        '커맨드는 반드시 0 (제거), 1 (추가), 2 (리스트 초기화) 중 하나만 선택해야 함. 만약, 0, 혹은 1을 실행한다면, 반드시 provider.WorkoutMenu를 매개변수로 받아야함.');

    switch (command) {
      case 0:
        setState(() {
          tempoList.remove(workout);
        });
        debugPrint("$tempoList");

      case 1:
        setState(() {
          tempoList.add(workout!);
        });
        debugPrint("$tempoList");
      case 2:
        setState(() {
          tempoList.clear();
        });
    }
  }

  void disposeTempoList() {
    tempoList.clear();
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

  Future<int> categorize() async {
    workoutListStore.initializeWorkouts();
    allWorkoutList.clear();

    /// 운동 목록 데이터를 부위별로 스토어의 자료에 삽입
    for (var key in keys) {
      final data = await database.getWorkoutMenusByPart(key);
      workoutListStore.categorizeOfPart(data);
    }

    /// 모든 운동들을 전체 리스트에 추가
    for (var workout in workoutList.values) {
      allWorkoutList.addAll(workout);
    }

    return 0;
  }

  @override
  void initState() {
    super.initState();

    if (widget.showAddPlanningScreen) {
      bottomAddButton = WideButton(
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
        child: const Text("운동 추가하기"),
      );
    } else if (widget.exchangedWorkoutIndex != null) {
      bottomAddButton = WideButton(
        onTapUpFunction: () {
          maked.Workout selectWorkout = maked.Workout(
            name: tempoList[0].name,
            showE1rm: tempoList[0].showE1rm,
          );
          routineProvider.exchangeUserSelectWorkout(
              widget.exchangedWorkoutIndex!, selectWorkout);

          Navigator.pop(context);
        },
        child: const Text("운동 교체하기"),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.watch<provider.RoutineProvider>();
    workoutListStore = context.read<provider.WorkoutListStore>();

    workoutList = workoutListStore.workouts;
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
          icon: const Icon(
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
        const Divider(
          thickness: 0.5,
          height: 0.0,
          color: palette.cardColorWhite,
        ),
        Expanded(
          child: FutureBuilder(
              future: categorize(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    "운동 목록을 불러오는 도중 오류가 발생하였습니다. 에러: ${snapshot.error}",
                    style: const TextStyle(
                      color: palette.cardColorWhite,
                    ),
                  );
                } else {
                  return [
                    WorkoutList(
                      items: workoutList[keys[0]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutList(
                      items: workoutList[keys[1]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutList(
                      items: workoutList[keys[2]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutList(
                      items: workoutList[keys[3]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutList(
                      items: workoutList[keys[4]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutList(
                      items: workoutList[keys[5]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                    WorkoutListAll(
                      searchText: searchText,
                      allWorkoutList: allWorkoutList,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                    ),
                  ][ChangePart.index];
                }
              }),
        ),
        // tempoListViewer,
        WorkoutListViewer(
          list: tempoList,
          managementTempoList: managementTempoList,
        ),
        bottomAddButton,
      ],
    );
  }
}

abstract class WorkoutListBase extends StatelessWidget {
  final List<provider.WorkoutMenu> tempoList;
  final void Function({provider.WorkoutMenu? workout, required int command})
      managementTempoList;

  final int? exchangedWorkoutIndex;

  const WorkoutListBase({
    super.key,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
  });
}

class WorkoutListAll extends WorkoutListBase {
  final String searchText;
  final List<provider.WorkoutMenu> allWorkoutList;

  const WorkoutListAll({
    Key? key,
    required this.searchText,
    required this.allWorkoutList,
    required List<provider.WorkoutMenu> tempoList,
    required void Function(
            {provider.WorkoutMenu? workout, required int command})
        managementTempoList,
    int? exchangedWorkoutIndex,
    void Function({maked.Workout? selectWorkout})? handleSelectExchangeWorkout,
    maked.Workout? selectExchangeWorkout,
  }) : super(
          key: key,
          tempoList: tempoList,
          managementTempoList: managementTempoList,
          exchangedWorkoutIndex: exchangedWorkoutIndex,
        );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allWorkoutList.length,
      itemBuilder: (context, index) {
        var hasMatch = RegExp(searchText).hasMatch(allWorkoutList[index].name);

        if (searchText.isNotEmpty && !hasMatch) {
          return const SizedBox.shrink();
        } else {
          return SelectBox(
            key: GlobalKey(),
            menu: allWorkoutList[index],
            tempoList: tempoList,
            managementTempoList: managementTempoList,
            exchangedWorkoutIndex: exchangedWorkoutIndex,
          );
        }
      },
    );
  }
}

class WorkoutList extends WorkoutListBase {
  final List<provider.WorkoutMenu> items;

  const WorkoutList({
    Key? key,
    required this.items,
    required List<provider.WorkoutMenu> tempoList,
    required void Function(
            {provider.WorkoutMenu? workout, required int command})
        managementTempoList,
    int? exchangedWorkoutIndex,
    void Function({maked.Workout? selectWorkout})? handleSelectExchangeWorkout,
    maked.Workout? selectExchangeWorkout,
  }) : super(
          key: key,
          tempoList: tempoList,
          managementTempoList: managementTempoList,
          exchangedWorkoutIndex: exchangedWorkoutIndex,
        );

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

  final void Function({
    provider.WorkoutMenu? workout,
    required int command,
  }) managementTempoList;

  const SelectBox({
    super.key,
    required this.menu,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _checker = false;

  @override
  void initState() {
    super.initState();

    if (widget.tempoList.contains(widget.menu)) {
      _checker = true;
    }
  }

  void _addWorkout() {
    setState(() {
      widget.managementTempoList(
        command: 1,
        workout: widget.menu,
      );
    });
  }

  void _deleteWorkout() {
    if (widget.tempoList.isNotEmpty) {
      setState(() {
        widget.managementTempoList(
          command: 0,
          workout: widget.menu,
        );
      });
    }
  }

  void _initializeList() {
    setState(() {
      widget.managementTempoList(
        command: 2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// 운동 교체 페이지에서 호출할 경우
        switch (widget.exchangedWorkoutIndex != null) {
          /// 운동 교체 페이지에서
          case true:
            if (_checker == false) {
              if (widget.tempoList.isEmpty) {
                setState(() {
                  _checker = true;
                  _addWorkout();
                });
              } else if (widget.tempoList.isNotEmpty) {
                setState(() {
                  _checker = true;
                  _initializeList();
                  _addWorkout();
                });
              }
            } else {
              if (widget.tempoList.isNotEmpty) {
                setState(() {
                  _checker = false;
                  _initializeList();
                });
              }
            }

          /// 운동 계획 페이지에서
          default:
            if (_checker == false) {
              if (widget.tempoList.contains(widget.menu) == false) {
                setState(() {
                  _checker = true;
                  _addWorkout();
                });
              }
            } else {
              if (widget.tempoList.contains(widget.menu)) {
                setState(() {
                  _checker = false;
                  _deleteWorkout();
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
          border: const Border(
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
              style: const TextStyle(
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
