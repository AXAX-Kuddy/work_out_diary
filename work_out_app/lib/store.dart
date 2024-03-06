
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_out_app/make_program.dart';

class Store extends ChangeNotifier {
  int pageNum = 0;

  Map<String, dynamic> userInfo = {
    "userName": "",
    "userSBD": [],
    "dotsPoint": "",
  };

  void changePage(int selectPage) {
    pageNum = selectPage;
    notifyListeners();
  }

  void addInfo({required String command, dynamic value}) {
    if (command == "name") {
      userInfo["userName"] = value;
    } else if (command == "sbd") {
      userInfo["userSBD"] = value;
    } else if (command == "dots") {
      userInfo["dotsPoint"] = value;
    }
  }

  bool infoChecker(Map<String, dynamic> userInfo) {
    for (var info in userInfo.entries) {
      if (info.value is String && info.value.isEmpty) {
        return false;
      } else if (info.value is List && info.value.isEmpty) {
        return false;
      }
    }
    return true;
  }

  double dotsCal(
    num bodyWeight,
    num weightLifted,
    bool isFemale,
  ) {
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

class WorkOutListStore extends ChangeNotifier {
  List workOut = [
    "스쿼트",
    "데드리프트",
    "벤치프레스",
    "밀리터리 프레스",
    "바벨 로우",
  ];
}

class UserProgramListStore extends ChangeNotifier {
  ///selectWorkOut 페이지에서 유저가 선택한 운동을 여기에 보관합니다.
  List userSelectWorkOut = [];

  ///사용자가 생성 및 받아온 루틴들은 모두 이곳에 보관함.
  List programs = [];

  void addProgram(Program program) {
    programs.add(program);
    notifyListeners();
  }

  void removeProgram(Program program) {
    programs.remove(program);
    notifyListeners();
  }

  Program getProgram(int index) {
    return programs[index];
  }
}
