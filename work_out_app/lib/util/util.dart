import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:drift/drift.dart' as drift;
import 'package:work_out_app/database/database.dart' as db;
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/provider/store.dart' as provider;
import 'package:work_out_app/screens/plan_screen/plan_screen.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';


class Tier {
  static final List<double> _tierPoints = [
    0,
    200,
    300,
    350,
    400,
    450,
  ];

  static List<double> get tierPoint => _tierPoints;

  static final List<String> _tierList = [
    "비기너",
    "주니어",
    "아마추어",
    "시니어",
    "어드밴스드 리프터",
    "프로 리프터",
  ];

  static List<String> get tierList => _tierList;

  static final List<Color> _colorList = [
    palette.tierLow,
    palette.tierMiddleLow,
    palette.tierMiddle,
    palette.tierMiddleHigh,
    palette.tierHigh,
    palette.tierVeryHigh,
  ];

  static List<Color> get colorList => _colorList;

  static int userTier(double dotsPoint) {
    if (dotsPoint >= 450) {
      return 5;
    } else if (dotsPoint >= 400) {
      return 4;
    } else if (dotsPoint >= 350) {
      return 3;
    } else if (dotsPoint >= 300) {
      return 2;
    } else if (dotsPoint >= 200) {
      return 1;
    } else {
      return 0;
    }
  }

  static String selectTierName(double dotsPoint) {
    return _tierList[userTier(dotsPoint)];
  }

  static Color selectTierColor(double dotsPoint) {
    return _colorList[userTier(dotsPoint)];
  }

  static double leftoverTierPoints(double dotsPoint) {
    int currentTier = userTier(dotsPoint);
    if (currentTier >= _tierList.length - 1) {
      return 0;
    }
    return _tierPoints[currentTier + 1] - dotsPoint;
  }
}

void updateRoutine(
    {required BuildContext context,
    required db.AppDatabase database,
    required db.Routine routine,
    required provider.RoutineProvider routineProvider,
    required List<maked.Workout> workoutList}) {
  Navigator.pop(context);

  SlidePage.goto(
      context: context,
      page: PlanningScreen(
        updateRoutine: (String children) async {
          await database.updateRoutine(
            selectRoutine: routine,
            companion: db.RoutinesCompanion(
              id: drift.Value(routine.id),
              routineName: drift.Value(routine.routineName),
              date: drift.Value(routine.date),
              isFavor: drift.Value(routine.isFavor),
              children: drift.Value(children),
            ),
          );
        },
        onPageLoaded: () {
          routineProvider.clearUserSelectWorkout();

          for (maked.Workout workout in workoutList) {
            routineProvider.addUserSelectWorkout(workout);
          }
        },
      ));
}

class RoutineDetail {
  String routineChildren;
  RoutineDetail(
    this.routineChildren,
  );

  final List<maked.Workout> _workoutList = [];

  void routineChildrenDecode(String children) {
    dynamic decodeJson = jsonDecode(children);
    debugPrint("$decodeJson");

    try {
      if (decodeJson is List<dynamic>) {
        for (var workout in decodeJson) {
          maked.Workout instance =
              maked.Workout.toJsonDecode(jsonDecode(workout));
          _workoutList.add(instance);
        }
      } else if (decodeJson is Map<String, dynamic>) {
        final maked.Workout instance = maked.Workout.toJsonDecode(decodeJson);
        _workoutList.add(instance);
      } else {
        throw TypeError();
      }
    } catch (event) {
      debugPrint(event.toString());
    }
  }

  List<maked.Workout> get getWorkoutList {
    routineChildrenDecode(routineChildren);

    return _workoutList;
  }

  List<Widget> get generateItems {
    routineChildrenDecode(routineChildren);

    return List.generate(_workoutList.length, (index) {
      final workout = _workoutList[index];

      return Container(
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: palette.cardColorYelGreen,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  workout.name!,
                  style: const TextStyle(
                    color: palette.cardColorWhite,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (workout.targetRpe >= 5.0)
                  Text(
                    "@${workout.targetRpe.toString()}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: palette.cardColorWhite,
                    ),
                  ),
              ],
            ),
            if (workout.sets!.isNotEmpty)
              Column(
                children: [
                  ...List.generate(workout.sets!.length, (index) {
                    final maked.WorkoutSet set = workout.sets![index];

                    return Row(
                      children: [
                        Text(
                          "${set.setIndex! + 1}.",
                          style: const TextStyle(
                            color: palette.cardColorWhite,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
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
                            fontSize: 11,
                            color: palette.cardColorWhite,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
          ],
        ),
      );
    });
  }
}
