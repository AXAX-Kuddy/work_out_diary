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

class Program {
  List<Week> weeks = [];

  void addWeek(Week week) {
    weeks.add(week);
  }

  void removeWeek(Week week) {
    weeks.remove(week);
  }

  Week getWeek(int index) {
    return weeks[index];
  }
}

class Week {
  int weekIndex;
  List<Day> days = [];

  Week(this.weekIndex);

  void addDay(Day day) {
    days.add(day);
  }

  void removeDay(Day day) {
    days.remove(day);
  }

  Day getDay(int index) {
    return days[index];
  }
}

class Day {
  int dayIndex;
  List<Workout> workouts = [];

  Day(this.dayIndex);

  void addWorkout(Workout workout) {
    workouts.add(workout);
  }

  void removeWorkout(Workout workout) {
    workouts.remove(workout);
  }

  Workout getWorkout(int index) {
    return workouts[index];
  }
}

class Workout {
  String name;
  List<Set> sets = [];

  Workout(this.name);

  void addSet(Set set) {
    sets.add(set);
  }

  void removeSet(Set set) {
    sets.remove(set);
  }

  Set getSet(int index) {
    return sets[index];
  }
}

class Set {
  int reps;
  double weight;
  double rpe;

  Set(this.reps, this.rpe, this.weight);
}
