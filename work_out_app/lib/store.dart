import 'package:flutter/material.dart';

class Store extends ChangeNotifier {
  int pageNum = 0;

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

  ///userSelectWorkOut 리스트의 상태관리를 위한 함수입니다.
  ///다음은 사용 예제입니다:
  ///```
  ///managedWorkOutList(input : "원하는 값", command : "실행할 작업");
  ///```
  ///
  ///만약 값을 추가하고 싶다면:
  ///```
  ///managedWorkOutList(input : "원하는 값", command : "add");
  ///```
  ///만약 값을 제거하고 싶다면:
  ///```
  ///managedWorkOutList(input : "원하는 값", command : "remove");
  ///```
  ///만약 리스트를 초기화 하고자 한다면:
  ///```
  ///managedWorkOutList(command : "reset");
  ///```
  void managedWorkOutList({
    String input = "",
    required String command,
  }) {
    if (command == "add") {
      userSelectWorkOut.add(input);
    } else if (command == "remove") {
      userSelectWorkOut.remove(input);
    } else if (command == "reset") {
      userSelectWorkOut = [];
    }
  }
}
