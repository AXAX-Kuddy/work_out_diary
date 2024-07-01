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
  isEdit,
}

extension UserInfoFieldExtention on UserInfoField {
  String get key {
    switch (this) {
      case UserInfoField.userName:
        return 'userName';
      case UserInfoField.userSBD:
        return 'userSBD';
      case UserInfoField.dotsPoint:
        return 'dotsPoint';
      case UserInfoField.age:
        return 'age';
      case UserInfoField.weight:
        return 'weight';
      case UserInfoField.isFemale:
        return 'isFemale';
      case UserInfoField.isEdit:
        return 'isEdit';
      default:
        return '';
    }
  }
}

enum SBDkeys {
  squat,
  benchPress,
  deadLift,
}

extension SBDKeysExtention on SBDkeys {
  String get key {
    switch (this) {
      case SBDkeys.squat:
        return "squat";

      case SBDkeys.benchPress:
        return "benchPress";

      case SBDkeys.deadLift:
        return "deadLift";

      default:
        return "";
    }
  }
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

enum DevelopName {
  devName,
}

extension DevelopNameExtension on DevelopName {
  String get key {
    switch (this) {
      case DevelopName.devName:
        return "TemporaryUser";
    }
  }
}
