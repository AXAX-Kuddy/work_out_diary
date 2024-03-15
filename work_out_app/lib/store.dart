import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_out_app/make_program.dart';

class Store extends ChangeNotifier {
  int pageNum = 0;

  void changePage(int selectPage) {
    pageNum = selectPage;
    print("페이지 전환 : $pageNum 페이지");
    notifyListeners();
  }

  ///```
  ///userInfo는 Map<String, dynamic>형식으로 되어있으며 Key값을 사용하여 자료를 쓸 수 있다.
  ///```
  ///
  ///```
  ///"userName" : String 유저이름
  ///```
  ///
  ///```
  ///"userSBD" : {"스쿼트": String, "벤치프레스": String, "데드리프트": String} 사용 시 num 으로 바꿔야함.
  ///```
  ///
  ///```
  ///"dotsPoint" : String 닷츠포인트
  ///```
  ///
  ///```
  ///"age" : String 나이
  ///```
  ///
  ///```
  ///"weight" : String 몸무게
  ///```
  ///
  ///```
  ///"isFemale" : bool 성별 유무
  ///```
  Map<String, dynamic> userInfo = {
    "editing": false,
    "userName": "유저",
    "userSBD": {
      "스쿼트": "100.5",
      "벤치프레스": "100.5",
      "데드리프트": "100.5",
    },
    "dotsPoint": "1000",
    "age": "99",
    "weight": "100",
    "isFemale": false,
  };

  void addInfo({required String command, dynamic value}) {
    if (command == "name") {
      userInfo["userName"] = value;
    } else if (command == "sbd") {
      userInfo["userSBD"] = value;
    } else if (command == "dots") {
      userInfo["dotsPoint"] = value;
    } else if (command == "age") {
      userInfo["age"] = value;
    } else if (command == "weight") {
      userInfo["weight"] = value;
    } else if (command == "isFemale") {
      userInfo["isFemale"] = value;
    }
  }

  bool infoChecker(Map<String, dynamic> userInfo) {
    var editCheck = userInfo["editing"];
    if (editCheck == false) {
      return false;
    } else {
      return true;
    }
  }

  void updateUserInfo(userInfo) {
    userInfo;
    notifyListeners();
  }

  double dotsCal({
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
  String comp= "컴피티션";

  Map<String, List<String>> workouts = {
    "하체": ["스쿼트", "컨벤셔널 데드리프트"],
    "등": ["바벨로우", "랫 풀 다운"],
    "가슴": ["벤치프레스", "인클라인 벤치프레스"],
    "어깨": ["스탠딩 밀리터리 프레스", "덤벨 숄더 프레스"],
    "이두" : ["바벨컬, 해머컬"],
    "삼두": ["클로즈 그립 벤치프레스", "케이블 푸시 다운"],
  };
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
