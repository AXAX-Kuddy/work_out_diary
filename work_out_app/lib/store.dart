import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_out_app/make_program.dart' as maked;
import 'package:work_out_app/keys.dart';
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

class WorkoutListStore extends ChangeNotifier {
  var workouts = {
    "하체": [
      maked.Workout(
        name: "스쿼트",
        showE1rm: true,
      ),
      maked.Workout(
        name: "데드리프트",
        showE1rm: true,
      ),
    ],
    "등": [
      maked.Workout(name: "랫 풀 다운"),
      maked.Workout(name: "바벨 로우"),
    ],
    "가슴": [
      maked.Workout(
        name: "벤치프레스",
        showE1rm: true,
      ),
      maked.Workout(name: "인클라인 덤벨 프레스"),
    ],
    "어깨": [
      maked.Workout(name: "밀리터리 프레스"),
      maked.Workout(name: "덤벨 숄더 프레스"),
    ],
    "이두": [
      maked.Workout(name: "바벨 컬"),
      maked.Workout(name: "해머 컬"),
    ],
    "삼두": [
      maked.Workout(name: "클로즈 그립 벤치프레스"),
      maked.Workout(name: "덤벨 스컬 크러셔"),
    ],
  };
}

class Routine {
  static final StopWatchTimer stopWatchTimer = StopWatchTimer();
  static final StopWatchTimer restTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    onEnded: () {
      restTimer.onResetTimer();
    },
  );

  int restTimeMin = 0;
  int restTimeSec = 0;
  int restTimeTotal = 0;

  List<maked.Workout> todayWorkouts = [];

  NowRestState restState = NowRestState.beforeRest;
  bool workoutStart = false;
  bool onRest = false;
}

class RoutineProvider extends ChangeNotifier {
  final Routine _routine;
  RoutineProvider(this._routine);
  Routine get routine => _routine;

  List<maked.Workout> get todayWorkouts => _routine.todayWorkouts;

  bool get workoutStart => _routine.workoutStart;

  bool get onRest => _routine.onRest;
  int get restTimeTotal => _routine.restTimeTotal;
  int get restTimeMin => _routine.restTimeMin;
  int get restTimeSec => _routine.restTimeSec;

  void addUserSelectWorkout(maked.Workout workout) {
    _routine.todayWorkouts.add(workout);
    notifyListeners();
  }

  void removeUserSelectWorkout(maked.Workout workout) {
    _routine.todayWorkouts.remove(workout);
    notifyListeners();
  }

  void setWorkoutStart() {
    _routine.workoutStart = true;
    notifyListeners();
  }

  void setWorkoutFinish() {
    _routine.workoutStart = false;
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

  void onStartedRestTimer() {
    Routine.restTimer.onStartTimer();
    notifyListeners();
  }

  void setRestTimer(bool value) {
    _routine.onRest = value;
    notifyListeners();
  }

  void setRestTimeMin(int value) {
    _routine.restTimeMin = value;
    notifyListeners();
  }

  void setRestTimeSec(int value) {
    _routine.restTimeSec = value;
    notifyListeners();
  }

  void totalRest() {
    int min = _routine.restTimeMin * 1000 * 60;
    int sec = _routine.restTimeSec * 1000;
    _routine.restTimeTotal = min + sec;

    Routine.restTimer.setPresetTime(mSec: _routine.restTimeTotal, add: false);
    notifyListeners();
  }
}
