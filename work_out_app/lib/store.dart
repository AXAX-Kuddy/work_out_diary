import 'package:flutter/material.dart';
import 'package:work_out_app/make_program.dart';

class Store extends ChangeNotifier {
  int pageNum = 0;

  String userName = "User";
  List<double> userSBD = [
    100.5,
    100.5,
    100.5,
  ];

  void changePage(int selectPage) {
    pageNum = selectPage;
    notifyListeners();
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

