import 'package:flutter/material.dart';
import 'package:work_out_app/util/palette.dart' as palette;

enum UserInfoField {
  userName,
  userSBD,
  dotsPoint,
  age,
  height,
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
      case UserInfoField.height:
        return 'height';
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
