enum UserInfoField {
  userName,
  userSBD,
  dotsPoint,
  age,
  height,
  weight,
  sex,
  isEdit,
}

extension UserInfoFieldExtention on UserInfoField {
  String get key {
    switch (this) {
      case UserInfoField.userName:
        return "userName";
      case UserInfoField.userSBD:
        return "userSBD";
      case UserInfoField.dotsPoint:
        return "dotsPoint";
      case UserInfoField.age:
        return "age";
      case UserInfoField.height:
        return "height";
      case UserInfoField.weight:
        return "weight";
      case UserInfoField.sex:
        return "sex";
      case UserInfoField.isEdit:
        return "isEdit";
      default:
        return '';
    }
  }
}

class SexType {
  static String get male => "남자";
  static String get female => "여자";
  static String get nonSelect => "미선택";
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
  cardio,
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
