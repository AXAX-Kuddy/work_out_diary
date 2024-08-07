import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/provider/store.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/todays_program.dart';
import 'package:work_out_app/screens/home_screen/home_screen_widgets/top_profile_card.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/box_widget/widget_box.dart';
import 'package:work_out_app/widgets/buttons/wide_button.dart';
import 'package:work_out_app/widgets/router/plan_screen_router.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/sliding_up_panel/sliding_up_panel.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/provider/store.dart' as provider;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RoutineProvider routineProvider;

  db.Routine? panelCallingInstance = db.Routine(
    id: 0,
    routineName: "placeHold",
    date: DateTime.now(),
    isFavor: false,
    children: "",
  );
  List<maked.Workout> panelCallingWorkouts = [];
  List<Widget> panelItems = [];

  final SlidingUpPanelController panelController = SlidingUpPanelController();

  void handlePanelController({
    required PanelControllerCommand command,
    db.Routine? routine,
  }) {
    switch (command) {
      case PanelControllerCommand.spread:
        setState(() {
          panelCallingInstance = routine;
          routineChildrenDecode(routine!.children);
          panelController.expand();
        });

      case PanelControllerCommand.hide:
        setState(() {
          panelController.hide();
        });

      default:
        null;
    }
  }

  void routineChildrenDecode(String children) {
    dynamic decodeJson = jsonDecode(children);
    debugPrint("$decodeJson");

    try {
      if (decodeJson is List<dynamic>) {
        for (var workout in decodeJson) {
          maked.Workout instance =
              maked.Workout.toJsonDecode(jsonDecode(workout));
          setPanelItems(instance);
        }
      } else if (decodeJson is Map<String, dynamic>) {
        final maked.Workout instance = maked.Workout.toJsonDecode(decodeJson);
        setPanelItems(instance);
      } else {
        throw TypeError();
      }
    } catch (event) {
      setState(() {
        panelItems.add(ErrorWidget("타입에러가 발생하였습니다. 발생경위 : $event"));
      });
    }
  }

  void clearPanelItems() {
    setState(() {
      panelCallingWorkouts.clear();
      panelItems.clear();
    });
  }

  void setPanelItems(maked.Workout instance) {
    setState(() {
      panelCallingWorkouts.add(instance);
      panelItems.add(
        PanelItem(
          index: panelItems.length,
          workoutInstance: instance,
        ),
      );
    });
  }

  void addWorkoutToPlanningScreen() {
    routineProvider.clearUserSelectWorkout();
    for (maked.Workout workout in panelCallingWorkouts) {
      routineProvider.addUserSelectWorkout(workout);
    }
    panelController.hide();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineProvider = context.read<provider.RoutineProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: SizedBox(
        width: 180,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: palette.bgFadeColor,
          onPressed: () {
            PlanningScreenRouter.go(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LineIcon(
                  LineIcons.angleLeft,
                  color: palette.cardColorWhite,
                  size: 30,
                ),
                Text(
                  "운동 기록",
                  style: TextStyle(
                    color: palette.cardColorWhite,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      slidingUpPanelWidget: CustomSlidingUpPanelWidget(
        onlyAnchor: false,
        showDragHandle: false,
        controller: panelController,
        onStatusChanged: (status) {
          if (status == SlidingUpPanelStatus.anchored) {
            panelController.hide();
          }
          if (status == SlidingUpPanelStatus.hidden) {
            clearPanelItems();
          }
        },
        children: [
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    panelCallingInstance?.routineName ?? "placeHold",
                    style: const TextStyle(
                      color: palette.colorWhite,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      clearPanelItems();
                      panelController.hide();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: palette.colorRed,
                    ),
                  )
                ],
              ),
            );
          }),
          PanelItemBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                ...panelItems,
                WideButton(
                  onTapUpFunction: () {
                    SlidePage.goto(
                      context: context,
                      page: PlanningScreen(
                        onPageLoaded: addWorkoutToPlanningScreen,
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text("해당 루틴으로 운동하기"),
                      Spacer(),
                      LineIcon(
                        LineIcons.angleRight,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      children: [
        const ProfileCard(),
        const SizedBox(
          height: 15,
        ),
        TodayWorkOutCard(
          handlePanelController: handlePanelController,
        ),
      ],
    );
  }
}

class PanelItem extends StatelessWidget {
  final int index;
  final maked.Workout workoutInstance;

  const PanelItem({
    super.key,
    required this.index,
    required this.workoutInstance,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsBox(
      width: 500,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      backgroundColor: palette.bgColor,
      border: Border.all(
        color: palette.bgColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                (index + 1).toString(),
                style: const TextStyle(
                  fontSize: 17,
                  color: palette.cardColorYelGreen,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                workoutInstance.name!,
                style: const TextStyle(
                  fontSize: 17,
                  color: palette.cardColorWhite,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (workoutInstance.targetRpe >= 5.0)
                Text(
                  "@${workoutInstance.targetRpe.toString()}",
                  style: const TextStyle(
                    color: palette.cardColorWhite,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            children: List.generate(
              workoutInstance.sets!.length,
              (index) {
                maked.WorkoutSet set = workoutInstance.sets![index];

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${(set.setIndex! + 1).toString()}.",
                        style: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "${set.weight}kg",
                            style: const TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "X",
                            style: TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            set.reps.toString(),
                            style: const TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "@${set.rpe.toString()}",
                            style: const TextStyle(
                              color: palette.cardColorWhite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
