class PageNumber {
  static int pageNum = 0;

  static changePage(int selectPage) {
    pageNum = selectPage;
  }
}

enum UserInfoField {
  userName,
  userSBD,
  dotsPoint,
  age,
  weight,
  isFemale,
}

enum SBDkeys {
  squat,
  benchPress,
  deadlift,
}

enum WorkoutListKeys {
  leg,
  back,
  chest,
  shoulder,
  biceps,
  triceps,
}

enum RoutinePreferencesKey {
  onRestStart,
  workoutStart,
  onRest,
  hasShowSnackbar,
  restTimeMin,
  restTimeSec,
  restTimeTotal,
}

extension SharedPreferencesKeyExtension on RoutinePreferencesKey {
  String get key {
    switch (this) {
      case RoutinePreferencesKey.onRestStart:
        return 'onRestStart';
      case RoutinePreferencesKey.workoutStart:
        return 'workoutStart';
      case RoutinePreferencesKey.onRest:
        return 'onRest';
      case RoutinePreferencesKey.hasShowSnackbar:
        return 'hasShowSnackbar';
      case RoutinePreferencesKey.restTimeMin:
        return 'restTimeMin';
      case RoutinePreferencesKey.restTimeSec:
        return 'restTimeSec';
      case RoutinePreferencesKey.restTimeTotal:
        return 'restTimeTotal';
      default:
        return '';
    }
  }
}

enum PanelControllerCommand {
  spread,
  anchor,
  hide,
}