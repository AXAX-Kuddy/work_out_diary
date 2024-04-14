import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:work_out_app/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen_widgets.dart/routine_page.dart';
import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
import 'package:work_out_app/screens/work_out_screen.dart';
import 'package:work_out_app/widgets/base_page.dart';
import 'package:work_out_app/widgets/drop_down.dart';
import 'package:work_out_app/widgets/wide_button.dart';
import 'package:work_out_app/widgets/widget_box.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

import 'package:work_out_app/make_program.dart' as maked;

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  late List<maked.Workout> workoutList;
  late void Function(maked.Workout) addWorkout;
  late void Function(maked.Workout) removeWorkout;

  @override
  void initState() {
    super.initState();
    workoutList =
        context.read<provider.UserProgramListStore>().userSelectWorkOut;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addWorkout =
        context.watch<provider.UserProgramListStore>().addUserSelectWorkout;
    removeWorkout =
        context.watch<provider.UserProgramListStore>().removeUserSelectWorkout;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: LineIcon(
              LineIcons.angleRight,
              color: palette.cardColorWhite,
              size: 30,
            )),
        title: GestureDetector(
          onTap: () {},
          child: const Text(
            "Planning",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
              itemCount: workoutList.isEmpty ? 1 : workoutList.length,
              itemBuilder: (BuildContext context, int index) {
                if (workoutList.isEmpty) {
                  return Center(
                    heightFactor: 20,
                    child: Text(
                      "운동을 추가해주세요!",
                      style: TextStyle(
                        fontSize: 20,
                        color: palette.cardColorWhite,
                      ),
                    ),
                  );
                } else {
                  return WorkoutDetail(
                    index: index,
                    workoutInstance: workoutList[index],
                    workoutList: workoutList,
                    removeWorkout: removeWorkout,
                  );
                }
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SelectWorkOut(
                      addFunction: (List<maked.Workout> selectList) {
                        for (int i = 0; i < selectList.length; i++) {
                          addWorkout(selectList[i]);
                        }
                      },
                      changedListner: () {
                        setState(() {
                          workoutList;
                        });
                      },
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: LineIcon.plus(
                color: palette.cardColorWhite,
                size: 28,
              ),
              label: Text(
                "운동추가",
                style: TextStyle(
                  fontSize: 17,
                  color: palette.cardColorWhite,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WorkoutDetail extends StatefulWidget {
  final int index;
  final void Function(maked.Workout) removeWorkout;
  final maked.Workout workoutInstance;

  const WorkoutDetail({
    super.key,
    required this.index,
    required this.workoutList,
    required this.removeWorkout,
    required this.workoutInstance,
  });

  final List<maked.Workout> workoutList;

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  String target = "타겟 RPE";
  final List<String> rpeList = [
    "5",
    "5.5",
    "6",
    "6.5",
    "7",
    "7.5",
    "8",
    "8.5",
    "9",
    "9.5",
    "10"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${widget.index + 1}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: palette.cardColorYelGreen,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.workoutInstance.name!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: palette.cardColorWhite,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String selectRpe = "0";
                    return Dialog(
                      backgroundColor: palette.bgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 300,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "목표 RPE를 선택해주세요!",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: palette.cardColorWhite,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropDownButton(
                                hint: "RPE",
                                textStyle: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                                itemList: rpeList,
                                itemTextStyle: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                                onChanged: (value) {
                                  selectRpe = value!;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectRpe = "0";
                                        target = "타겟 RPE";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "초기화",
                                      style: TextStyle(
                                          color: palette.cardColorWhite),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (selectRpe == "0") {
                                        setState(() {
                                          target = "타겟 RPE";
                                        });
                                      } else {
                                        setState(() {
                                          target = selectRpe;
                                        });
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "확인",
                                      style: TextStyle(
                                        color: palette.cardColorYelGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Text(
                    "@$target",
                    style: TextStyle(
                      fontSize: 16,
                      color: palette.cardColorWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  LineIcon(
                    LineIcons.pen,
                    size: 17,
                    color: palette.cardColorWhite,
                  )
                ],
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
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(25),
                      backgroundColor: Colors.transparent,
                      content: Text(
                        "${widget.workoutInstance.name}를(을) 목록에서 삭제 하시겠습니까?",
                        style: TextStyle(
                          fontSize: 16,
                          color: palette.cardColorWhite,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "취소",
                                style: TextStyle(
                                  color: palette.cardColorWhite,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.removeWorkout(widget.workoutInstance);
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "확인",
                                style: TextStyle(
                                  color: palette.cardColorYelGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const LineIcon(
                color: Colors.red,
                size: 24,
                LineIcons.trash,
              ),
            )
          ],
        ),
        const Divider(
          height: 20,
        ),
        const TopDivider(),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: List.generate(
            widget.workoutInstance.sets!.length,
            (index) {
              return const SetsDetail();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                if (widget.workoutInstance.sets!.isNotEmpty) {
                  setState(() {
                    maked.Set getSet = widget.workoutInstance.sets!.last;
                    widget.workoutInstance.removeSet(getSet);
                  });
                }
              },
              icon: const LineIcon(
                LineIcons.minus,
                size: 22,
                color: Colors.red,
              ),
              label: const Text(
                "세트 삭제",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (widget.workoutInstance.sets!.isEmpty) {
                  maked.Set newSet = maked.Set(
                    setIndex: widget.workoutInstance.sets!.length,
                  );
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                } else {
                  maked.Set newSet = widget.workoutInstance.sets!.last;
                  setState(() {
                    widget.workoutInstance.addSet(newSet);
                  });
                }
              },
              icon: LineIcon(
                LineIcons.plus,
                size: 22,
                color: palette.cardColorYelGreen,
              ),
              label: Text(
                "세트 추가",
                style: TextStyle(
                  fontSize: 16,
                  color: palette.cardColorYelGreen,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SetsDetail extends StatefulWidget {
  const SetsDetail({super.key});

  @override
  State<SetsDetail> createState() => _SetsDetailState();
}

class _SetsDetailState extends State<SetsDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "세트",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.cardColorWhite,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "무게",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "갯수",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "RPE",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "완료",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
      ],
    );
  }
}

class TopDivider extends StatelessWidget {
  const TopDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "세트",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.cardColorWhite,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "무게",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "갯수",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "RPE",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "완료",
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.cardColorWhite),
          ),
        ),
      ],
    );
  }
}
