import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/provider/make_program.dart' as maked;
import 'package:work_out_app/util/keys.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:work_out_app/database/database.dart';

typedef UserInfo = Map<UserInfoField, dynamic>;

class PageNumber extends ChangeNotifier {
  int _pageNum = 0;

  int get pageNum => _pageNum;

  changePage(int selectPage) {
    _pageNum = selectPage;
    notifyListeners();
  }
}

class MainStore {
  static UserInfo userInfo = {
    UserInfoField.userName: DevelopName.devName.key,
    UserInfoField.userSBD: <SBDkeys, double>{
      SBDkeys.squat: 0.0,
      SBDkeys.benchPress: 0.0,
      SBDkeys.deadLift: 0.0,
    },
    UserInfoField.dotsPoint: 0.0,
    UserInfoField.age: null,
    UserInfoField.height: null,
    UserInfoField.weight: null,
    UserInfoField.sex: SexType.nonSelect,
    UserInfoField.isEdit: false,
  };
}

class MainStoreProvider extends ChangeNotifier {
  UserInfo get userInfo => MainStore.userInfo;

  Map<SBDkeys, double> get sbd => userInfo[UserInfoField.userSBD];
  double get squatWeight => userInfo[UserInfoField.userSBD][SBDkeys.squat];
  double get benchWeight => userInfo[UserInfoField.userSBD][SBDkeys.benchPress];
  double get deadWeight => userInfo[UserInfoField.userSBD][SBDkeys.deadLift];
  double get sbdTotal {
    double total = squatWeight + benchWeight + deadWeight;

    return total;
  }

  void setUserInfo({
    required UserInfoField userInfoField,
    required dynamic value,
  }) {
    /// 유저명 타입 불일치 검사
    if (userInfoField == UserInfoField.userName) {
      if (value is! String) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.userName일 경우, 반드시 value는 String타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 SBD기록 타입 불일치 검사
    if (userInfoField == UserInfoField.userSBD) {
      throw ArgumentError(
        "userInfoField가 UserInfoField.userSBD일 경우, 반드시 MainStoreProvider의 setSBD 메서드로 SBD값을 수정해야함.",
        "틀린 사용",
      );
    }

    /// 유저 닷츠 포인트 타입 불일치 검사
    if (userInfoField == UserInfoField.dotsPoint) {
      if (value is! double) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.dotsPoint일 경우, 반드시 value는 double타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 나이 타입 불일치 검사
    if (userInfoField == UserInfoField.age) {
      if (value is! int) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.age일 경우, 반드시 value는 int타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 신장 타입 불일치 검사
    if (userInfoField == UserInfoField.height) {
      if (value is! double) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.height일 경우, 반드시 value는 double타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 몸무게 타입 불일치 검사
    if (userInfoField == UserInfoField.weight) {
      if (value is! double) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.weight일 경우, 반드시 value는 double타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 성별 타입 불일치 검사
    if (userInfoField == UserInfoField.sex) {
      if (value is! String) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.gender일 경우, 반드시 value는 SexType.[value].value이여야 함.",
          "타입 불일치",
        );
      }
    }

    /// 유저 성별 타입 불일치 검사
    if (userInfoField == UserInfoField.isEdit) {
      if (value is! bool) {
        throw ArgumentError(
          "userInfoField가 UserInfoField.isEdit일 경우, 반드시 value는 bool타입이여야 함.",
          "타입 불일치",
        );
      }
    }

    MainStore.userInfo[userInfoField] = value;
    debugPrint(MainStore.userInfo[userInfoField].toString());
  }

  UserInfo getUserInfo() {
    return MainStore.userInfo;
  }

  /// 사용자 SBD 기록 설정
  void setSBD({
    required SBDkeys key,
    required double value,
  }) {
    sbd[key] = value;
  }

  static double dotsCal({
    required num bodyWeight,
    required num weightLifted,
    required String sex,
  }) {
    bool isFemale = false;

    if (sex == SexType.male) {
      isFemale = false;
    } else {
      isFemale = true;
    }

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

  Future<bool> _saveBodyInfo(SharedPreferences prefs, double weight) async {
    await prefs.setDouble(
      UserInfoField.weight.key,
      weight,
    );

    setDots(null);

    await prefs.setDouble(
      UserInfoField.dotsPoint.key,
      userInfo[UserInfoField.dotsPoint],
    );

    return Future.value(true);
  }

  void setDots(num? userSBD) {
    num weightLifted = userSBD ?? squatWeight + benchWeight + deadWeight;

    double result = dotsCal(
        bodyWeight: userInfo[UserInfoField.weight],
        weightLifted: weightLifted,
        sex: userInfo[UserInfoField.sex]);

    userInfo[UserInfoField.dotsPoint] = result;
  }

  Future<bool> savePreferencesOnly(dynamic key, dynamic value) async {
    if (key is! UserInfoField && key is! SBDkeys) {
      throw ArgumentError("key의 타입은 반드시 UserInfoField나 SBDKeys여야 합니다.");
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      switch (key) {
        case UserInfoField.userName:
          return await prefs.setString(
            UserInfoField.userName.key,
            value,
          );

        case SBDkeys.squat:
          return await prefs.setDouble(
            SBDkeys.squat.key,
            value,
          );
        case SBDkeys.benchPress:
          return await prefs.setDouble(
            SBDkeys.benchPress.key,
            value,
          );
        case SBDkeys.deadLift:
          return await prefs.setDouble(
            SBDkeys.deadLift.key,
            value,
          );

        case UserInfoField.dotsPoint:
          return await prefs.setDouble(
            UserInfoField.dotsPoint.key,
            value,
          );

        case UserInfoField.age:
          return await prefs.setInt(
            UserInfoField.age.key,
            value,
          );

        case UserInfoField.height:
          return await prefs.setDouble(
            UserInfoField.height.key,
            value,
          );

        case UserInfoField.weight:
          return _saveBodyInfo(
            prefs,
            value,
          );

        case UserInfoField.sex:
          return await prefs.setString(
            UserInfoField.sex.key,
            value,
          );

        case UserInfoField.isEdit:
          return await prefs.setBool(
            UserInfoField.isEdit.key,
            value,
          );

        default:
          return await Future.value(false);
      }
    }
  }

  /// 기기에 userInfo 저장
  Future<void> savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 유저 이름
    await prefs.setString(
      UserInfoField.userName.key,
      userInfo[UserInfoField.userName],
    );

    /// 유저 SBD 기록
    await prefs.setDouble(
      SBDkeys.squat.key,
      squatWeight,
    );
    await prefs.setDouble(
      SBDkeys.benchPress.key,
      benchWeight,
    );
    await prefs.setDouble(
      SBDkeys.deadLift.key,
      deadWeight,
    );

    /// 닷츠 포인트
    await prefs.setDouble(
      UserInfoField.dotsPoint.key,
      userInfo[UserInfoField.dotsPoint],
    );

    /// 유저 나이
    await prefs.setInt(
      UserInfoField.age.key,
      userInfo[UserInfoField.age],
    );

    /// 키
    await prefs.setDouble(
      UserInfoField.height.key,
      userInfo[UserInfoField.height],
    );

    /// 몸무게
    await prefs.setDouble(
      UserInfoField.weight.key,
      userInfo[UserInfoField.weight],
    );

    /// 성별
    await prefs.setString(
      UserInfoField.sex.key,
      userInfo[UserInfoField.sex],
    );

    /// 유저 정보 수정 여부
    await prefs.setBool(
      UserInfoField.isEdit.key,
      userInfo[UserInfoField.isEdit],
    );
  }

  /// 기기에 저장된 userInfo 불러오기
  Future<int> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 유저 이름
    userInfo[UserInfoField.userName] =
        prefs.getString(UserInfoField.userName.key) ?? DevelopName.devName.key;

    /// 유저 SBD 기록
    userInfo[UserInfoField.userSBD][SBDkeys.squat] =
        prefs.getDouble(SBDkeys.squat.key) ?? 0.0;
    userInfo[UserInfoField.userSBD][SBDkeys.benchPress] =
        prefs.getDouble(SBDkeys.benchPress.key) ?? 0.0;
    userInfo[UserInfoField.userSBD][SBDkeys.deadLift] =
        prefs.getDouble(SBDkeys.deadLift.key) ?? 0.0;

    /// 닷츠 포인트
    userInfo[UserInfoField.dotsPoint] =
        prefs.getDouble(UserInfoField.dotsPoint.key) ?? 0.0;

    /// 나이
    userInfo[UserInfoField.age] = prefs.getInt(UserInfoField.age.key);

    /// 몸무게
    userInfo[UserInfoField.weight] = prefs.getDouble(UserInfoField.weight.key);

    /// 몸무게
    userInfo[UserInfoField.height] = prefs.getDouble(UserInfoField.height.key);

    /// 성별
    userInfo[UserInfoField.sex] =
        prefs.getString(UserInfoField.sex.key) ?? SexType.nonSelect;

    /// userInfo 수정 여부
    userInfo[UserInfoField.isEdit] =
        prefs.getBool(UserInfoField.isEdit.key) ?? false;

    return 0;
  }

  /// 기기에 저장된 userInfo 모두 초기화
  Future<void> resetPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 유저 이름
    await prefs.setString(
      UserInfoField.userName.key,
      DevelopName.devName.key,
    );

    /// 유저 SBD 기록
    await prefs.setDouble(
      SBDkeys.squat.key,
      0.0,
    );
    await prefs.setDouble(
      SBDkeys.benchPress.key,
      0.0,
    );
    await prefs.setDouble(
      SBDkeys.deadLift.key,
      0.0,
    );

    /// 닷츠 포인트
    await prefs.setDouble(
      UserInfoField.dotsPoint.key,
      0.0,
    );

    /// 유저 나이
    await prefs.remove(UserInfoField.age.key);

    /// 키
    await prefs.remove(UserInfoField.height.key);

    /// 몸무게
    await prefs.remove(UserInfoField.weight.key);

    /// 성별
    await prefs.setString(
      UserInfoField.sex.key,
      SexType.nonSelect,
    );

    /// 유저 정보 수정 여부
    await prefs.setBool(
      UserInfoField.isEdit.key,
      false,
    );
  }
}

/// 운동 종목 구성
class WorkoutMenu {
  /// 운동 이름
  final String name;

  /// 종목 타입
  final String exerciseType;

  /// 메모
  final String? memo;

  /// e1rm표시유무
  final bool showE1rm;

  WorkoutMenu({
    required this.name,
    this.exerciseType = "barbell",
    this.memo,
    this.showE1rm = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkoutMenu &&
        other.name == name &&
        other.memo == memo &&
        other.showE1rm == showE1rm &&
        other.exerciseType == exerciseType;
  }

  @override
  int get hashCode => name.hashCode ^ memo.hashCode ^ showE1rm.hashCode ^ exerciseType.hashCode;
}

class WorkoutListStore extends ChangeNotifier {
  Map<WorkoutListKeys, List<WorkoutMenu>> workouts = {
    WorkoutListKeys.leg: [],
    WorkoutListKeys.back: [],
    WorkoutListKeys.chest: [],
    WorkoutListKeys.shoulder: [],
    WorkoutListKeys.biceps: [],
    WorkoutListKeys.triceps: [],
  };

  /// 운동 목록 초기화
  void initializeWorkouts() {
    for (var workout in workouts.values) {
      workout.clear();
    }
  }

  /// 특정 부위에 해당하는 운동 목록 리스트를 스토어에 삽입함
  Future<void> categorizeOfPart(List<WorkoutMenuData> workoutData) async {
    for (var data in workoutData) {
      if (workouts.containsKey(data.part)) {
        WorkoutMenu newMenu = WorkoutMenu(
          name: data.name,
          
          memo: data.memo,
          showE1rm: data.showE1rm,
        );
        if (!workouts[data.part]!.contains(newMenu)) {
          workouts[data.part]?.add(newMenu);
        }
      }
    }
  }
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

  void exchangeUserSelectWorkout(int index, maked.Workout workout) {
    todayWorkouts[index] = workout;
    notifyListeners();
  }

  void clearUserSelectWorkout() {
    todayWorkouts.clear();
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
    onStoppedRestTimer();
    Routine.restTimer.clearPresetTime();
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

    debugPrint("save");
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

    debugPrint("load");
  }
}
