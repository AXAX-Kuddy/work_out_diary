// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/buttons/cancel_and_enter_buttons.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/dialog/custom_dialog.dart';
import 'package:work_out_app/widgets/grid_loading_circle/loading_circle.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/add_custom_workout_screen.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/listview_of_part.dart';
import 'package:work_out_app/widgets/work_out_library/widgets/search_of_workout.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:provider/provider.dart';
import 'package:work_out_app/provider/store.dart' as provider;
import '../../util/util.dart';

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
  final bool showAppbarCloseButton;
  final bool showAddCustomButton;
  final bool exchangedSelectBoxToDetail;
  final int? exchangedWorkoutIndex;
  final void Function()? changedListner;

  const WorkoutLibrary({
    Key? key,
    required this.showAddPlanningScreen,
    required this.showAppbarCloseButton,
    this.showAddCustomButton = false,
    this.exchangedSelectBoxToDetail = false,
    this.exchangedWorkoutIndex,
    this.changedListner,
  }) : super(key: key);

  @override
  State<WorkoutLibrary> createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState extends State<WorkoutLibrary> {
  late db.AppDatabase database;
  late provider.RoutineProvider routineProvider;
  late provider.WorkoutListStore workoutListStore;

  late Map<WorkoutListKeys, List<provider.WorkoutMenu>> workoutList;
  final List<WorkoutListKeys> keys = WorkoutListKeys.values;

  List<provider.WorkoutMenu> tempoList = [];
  List<provider.WorkoutMenu> allWorkoutList = [];

  String searchText = "";

  late Widget bottomAddButton = const SizedBox.shrink();
  late Widget bottomAddCustomWorkoutButton = const SizedBox.shrink();
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
    /// 전체 운동목록 리스트 초기화
    allWorkoutList.clear();

    /// 운동 목록 데이터를 부위별로 스토어에 삽입
    for (var key in keys) {
      final data = await database.getWorkoutMenusByPart(key);
      workoutListStore.categorizeOfPart(data);
    }

    /// 모든 운동들을 전체 리스트에 추가
    for (var workout in workoutList.values) {
      allWorkoutList.addAll(workout);
    }

    debugPrint("카테고리 정렬");
    return 0;
  }

  @override
  void initState() {
    super.initState();

    workoutListStore = context.read<provider.WorkoutListStore>();

    workoutList = workoutListStore.workouts;

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
    }
    if (widget.exchangedWorkoutIndex != null) {
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
    if (widget.showAddCustomButton) {
      bottomAddCustomWorkoutButton = WideButton(
        onTapUpFunction: () {
          SlidePage.goto(
            context: context,
            page: AddCustomWorkoutScreen(
              categorize: categorize,
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LineIcon(LineIcons.plus),
            Text(
              "사용자 지정 운동 추가",
            ),
          ],
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    database = Provider.of<db.AppDatabase>(context);
    routineProvider = context.watch<provider.RoutineProvider>();
  }

  @override
  void dispose() {
    ChangePart.dispose();
    disposeTempoList();

    super.dispose();
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
        leading: widget.showAppbarCloseButton
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: palette.cardColorWhite,
                ),
              )
            : null,
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
                    child: LoadingCircle(),
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
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[1]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[2]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[3]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[4]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[5]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[6]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutList(
                      items: workoutList[keys[7]]!,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
                    ),
                    WorkoutListAll(
                      searchText: searchText,
                      allWorkoutList: allWorkoutList,
                      tempoList: tempoList,
                      managementTempoList: managementTempoList,
                      exchangedWorkoutIndex: widget.exchangedWorkoutIndex,
                      exchangedSelectBoxToDetail:
                          widget.exchangedSelectBoxToDetail,
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

        bottomAddCustomWorkoutButton,
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

  final bool? exchangedSelectBoxToDetail;

  const WorkoutListBase({
    super.key,
    required this.tempoList,
    required this.managementTempoList,
    this.exchangedWorkoutIndex,
    this.exchangedSelectBoxToDetail,
  });
}

class WorkoutListAll extends WorkoutListBase {
  final String searchText;
  final List<provider.WorkoutMenu> allWorkoutList;

  const WorkoutListAll({
    super.key,
    required this.searchText,
    required this.allWorkoutList,
    required super.tempoList,
    required super.managementTempoList,
    super.exchangedWorkoutIndex,
    super.exchangedSelectBoxToDetail,
    // void Function({maked.Workout? selectWorkout})? handleSelectExchangeWorkout,
    // maked.Workout? selectExchangeWorkout,
  });

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
            exchangedSelectBoxToDetail: exchangedSelectBoxToDetail,
          );
        }
      },
    );
  }
}

class WorkoutList extends WorkoutListBase {
  final List<provider.WorkoutMenu> items;

  const WorkoutList({
    super.key,
    required this.items,
    required super.tempoList,
    required super.managementTempoList,
    super.exchangedWorkoutIndex,
    super.exchangedSelectBoxToDetail,
    // void Function({maked.Workout? selectWorkout})? handleSelectExchangeWorkout,
    // maked.Workout? selectExchangeWorkout,
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
          exchangedSelectBoxToDetail: exchangedSelectBoxToDetail,
        );
      },
    );
  }
}

class SelectBox extends StatefulWidget {
  final provider.WorkoutMenu menu;
  final List<provider.WorkoutMenu> tempoList;
  final int? exchangedWorkoutIndex;
  final bool? exchangedSelectBoxToDetail;

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
    this.exchangedSelectBoxToDetail,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  bool _checker = false;

  Color nowColor = Colors.transparent;

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
    if (widget.exchangedSelectBoxToDetail != null) {
      if (widget.exchangedSelectBoxToDetail!) {
        return GestureDetector(
          onTapUp: (details) {
            setState(() {
              nowColor = Colors.transparent;
            });
          },
          onTapDown: (details) {
            setState(() {
              nowColor = palette.selectColor;
            });
          },
          onTapCancel: () {
            setState(() {
              nowColor = Colors.transparent;
            });
          },
          child: Container(
            height: 65,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: nowColor,
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
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            children: [
                              Text(
                                widget.menu.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: palette.cardColorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 17.5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "사용 기구 : ",
                                    style: TextStyle(
                                      color: palette.cardColorWhite,
                                    ),
                                  ),
                                  Text(
                                    widget.menu.exerciseType,
                                    style: const TextStyle(
                                      color: palette.cardColorYelGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                          children: [
                                            const Text(
                                              "e1rm 표시 유무 설정",
                                              style: TextStyle(
                                                color: palette.cardColorWhite,
                                              ),
                                            ),
                                            CancelAndEnterButton(
                                              cancelLabel: const Text(
                                                "표시하지 않음",
                                                style: TextStyle(
                                                  color: palette.colorRed,
                                                ),
                                              ),
                                              enterLabel: const Text(
                                                "표시 함",
                                                style: TextStyle(
                                                  color:
                                                      palette.cardColorYelGreen,
                                                ),
                                              ),
                                              onCancelTap: () {},
                                              onEnterTap: () {},
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "e1rm 표시 : ",
                                      style: TextStyle(
                                        color: palette.cardColorWhite,
                                      ),
                                    ),
                                    Text(
                                      widget.menu.showE1rm ? "표시 중" : "표시하지 않음",
                                      style: TextStyle(
                                        color: widget.menu.showE1rm
                                            ? palette.cardColorYelGreen
                                            : palette.colorRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const LineIcon(
                    LineIcons.verticalEllipsis,
                    color: palette.cardColorWhite,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

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
