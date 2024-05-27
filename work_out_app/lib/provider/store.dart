import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/util/keys.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

typedef UserInfo = Map<UserInfoField, dynamic>;

class MainStore {
  static UserInfo userInfo = {
    UserInfoField.userName: "유저",
    UserInfoField.userSBD: {
      SBDkeys.squat: 0.0,
      SBDkeys.benchPress: 0.0,
      SBDkeys.deadlift: 0.0,
    },
    UserInfoField.dotsPoint: 0.0,
    UserInfoField.age: 20,
    UserInfoField.weight: 100.0,
    UserInfoField.isFemale: false,
  };
}

class MainStoreProvider extends ChangeNotifier {
  final MainStore _mainStore;
  MainStoreProvider(
    this._mainStore,
  );
  MainStore get mainStore => _mainStore;

  void setUserInfo({
    required UserInfoField userInfoField,
    dynamic value,
  }) {
    MainStore.userInfo[userInfoField] = value;
  }

  static double dotsCal({
    required num bodyWeight,
    required num weightLifted,
    required bool isFemale,
  }) {
    var maleCoefficient = [
      -307.75076,
      24.0900756,
      -0.1918759221,
      0.0007391293,
      -0.000001093,
    ];

    var femaleCoefficient = [
      -125.425539779509,
      13.7121941940668,
      -0.0330725063103405,
      -1.0504000506583e-3,
      9.38773881462799e-6,
      -2.3334613884954e-8,
    ];
    var denominator = isFemale ? femaleCoefficient[0] : maleCoefficient[0];
    var coeff = isFemale ? femaleCoefficient : maleCoefficient;
    var maxBW = isFemale ? 150 : 210;
    var bw = min(max(bodyWeight, 40), maxBW);

    for (int i = 1; i < coeff.length; i++) {
      denominator += coeff[i] * pow(bw, i);
    }

    var result = (500 / denominator) * weightLifted;
    var score = result.toStringAsFixed(2);
    return double.parse(score);
  }
}

class MemoList {
  final String? notifiMemo;
  final List<Map<DateTime, String>>? memos;

  MemoList({
    this.notifiMemo,
    this.memos,
  });
}

/// 운동 종목 구성
class WorkoutMenu {
  ///운동 이름
  final String name;

  /// 메모
  final MemoList? memo;

  ///e1rm표시유무
  final bool showE1rm;

  WorkoutMenu({
    required this.name,
    this.memo,
    this.showE1rm = false,
  });
}

class WorkoutListStore extends ChangeNotifier {
  var workouts = {
    WorkoutListKeys.leg: [
      WorkoutMenu(
        name: "스쿼트",
        showE1rm: true,
      ),
      WorkoutMenu(
        name: "데드리프트",
        showE1rm: true,
      ),
    ],
    WorkoutListKeys.back: [
      WorkoutMenu(
        name: "랫 풀 다운",
      ),
      WorkoutMenu(
        name: "바벨 로우",
      ),
    ],
    WorkoutListKeys.chest: [
      WorkoutMenu(
        name: "바벨 벤치 프레스",
        showE1rm: true,
      ),
      WorkoutMenu(
        name: "인클라인 덤벨 프레스",
      ),
    ],
    WorkoutListKeys.shoulder: [
      WorkoutMenu(
        name: "바벨 밀리터리 프레스",
      ),
      WorkoutMenu(
        name: "사이드 레터럴 레이즈",
      ),
    ],
    WorkoutListKeys.biceps: [
      WorkoutMenu(
        name: "바벨 컬",
      ),
      WorkoutMenu(
        name: "해머 컬",
      ),
    ],
    WorkoutListKeys.triceps: [
      WorkoutMenu(
        name: "클로즈 그립 벤치프레스",
      ),
      WorkoutMenu(
        name: "덤벨 스컬 크러셔",
      ),
    ],
  };
}

class Routine {
  static final StopWatchTimer stopWatchTimer = StopWatchTimer();
  static final StopWatchTimer restTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    onEnded: () {
      onRestStart = false;
      restTimer.onResetTimer();
    },
  );

  static int restTimeMin = 0;
  static int restTimeSec = 0;
  static int restTimeTotal = 0;

  List<maked.Workout> todayWorkouts = [];

  static bool onRestStart = false;
  static bool workoutStart = false;
  static bool onRest = false;
  static bool hasShowSnackbar = false;
}

class RoutineProvider extends ChangeNotifier {
  final Routine _routine;
  RoutineProvider(this._routine);
  Routine get routine => _routine;

  List<maked.Workout> get todayWorkouts => _routine.todayWorkouts;
  bool get workoutStart => Routine.workoutStart;

  bool get onRest => Routine.onRest;
  bool get hasShowSnackbar => Routine.hasShowSnackbar;
  bool get onRestStart => Routine.onRestStart;
  dynamic get restRawTime => Routine.restTimer.rawTime;
  int get restTimeTotal => Routine.restTimeTotal;
  int get restTimeMin => Routine.restTimeMin;
  int get restTimeSec => Routine.restTimeSec;

  void addUserSelectWorkout(maked.Workout workout) {
    todayWorkouts.add(workout);
    notifyListeners();
  }

  void removeUserSelectWorkout(maked.Workout workout) {
    todayWorkouts.remove(workout);
    notifyListeners();
  }

  void setWorkoutStart() {
    Routine.workoutStart = true;
    notifyListeners();
  }

  void setWorkoutFinish() {
    Routine.workoutStart = false;
    notifyListeners();
  }

  void onWorkoutTimerStart() {
    Routine.stopWatchTimer.onStartTimer();
    notifyListeners();
  }

  void onWorkoutTimerStopped() {
    Routine.stopWatchTimer.onStopTimer();
    notifyListeners();
  }

  Future<void> onDisposeWorkoutTimer() async {
    await Routine.stopWatchTimer.dispose();
  }

  void onStartedRestTimer() {
    Routine.onRestStart = true;
    Routine.restTimer.onStartTimer();
    notifyListeners();
  }

  void setRestTimer(bool value) {
    Routine.onRest = value;
    savePreferences();
    notifyListeners();
  }

  void setRestTimeMin(int value) {
    Routine.restTimeMin = value;
    savePreferences();
    notifyListeners();
  }

  void setRestTimeSec(int value) {
    Routine.restTimeSec = value;
    savePreferences();
    notifyListeners();
  }

  void totalRest() {
    int min = Routine.restTimeMin * 1000 * 60;
    int sec = Routine.restTimeSec * 1000;
    Routine.restTimeTotal = min + sec;

    Routine.restTimer.setPresetTime(mSec: Routine.restTimeTotal, add: false);
    savePreferences();
    // notifyListeners();
  }

  void onStoppedRestTimer() {
    Routine.onRestStart = false;
    Routine.restTimer.onStopTimer();
    notifyListeners();
  }

  void onResetRestTimer() {
    Routine.onRestStart = false;
    Routine.restTimer.onResetTimer();
    notifyListeners();
  }

  Future<void> onDisposeRestTimer() async {
    await Routine.restTimer.dispose();
    notifyListeners();
  }

  void setRestSnackbarState(bool value) {
    Routine.hasShowSnackbar = value;
    notifyListeners();
  }

  void resetRestSnackbarShown() {
    Routine.hasShowSnackbar = false;
    notifyListeners();
  }

  Future<void> savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(RoutinePreferencesKey.onRest.key, Routine.onRest);

    await prefs.setInt(
        RoutinePreferencesKey.restTimeMin.key, Routine.restTimeMin);
    await prefs.setInt(
        RoutinePreferencesKey.restTimeSec.key, Routine.restTimeSec);
    await prefs.setInt(
        RoutinePreferencesKey.restTimeTotal.key, Routine.restTimeTotal);
    print("save");
  }

  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Routine.onRest = prefs.getBool(RoutinePreferencesKey.onRest.key) ?? false;

    Routine.restTimeMin =
        prefs.getInt(RoutinePreferencesKey.restTimeMin.key) ?? 0;
    Routine.restTimeSec =
        prefs.getInt(RoutinePreferencesKey.restTimeSec.key) ?? 0;
    Routine.restTimeTotal =
        prefs.getInt(RoutinePreferencesKey.restTimeTotal.key) ?? 0;

    print("load");
  }
}
