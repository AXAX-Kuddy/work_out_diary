import 'package:flutter/material.dart';


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

