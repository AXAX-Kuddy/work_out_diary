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
