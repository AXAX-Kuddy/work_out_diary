import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/store.dart' as provider;

class Program {
  late String? programName;
  late List<Week>? weeks;

  Program({
    required this.programName,
    List<Week>? weeks,
  }) : weeks = weeks ?? [];

  void addWeek(Week week) {
    weeks?.add(week);
  }

  void removeWeek(Week week) {
    weeks?.remove(week);
  }

  Week getWeek(int index) {
    return weeks![index];
  }

  void editProgramName(String editName) {
    programName = editName;
  }
}

class Week {
  late int weekIndex;
  late List<Day>? days;

  Week({
    this.weekIndex = 0,
    List<Day>? days,
  }) : days = days ?? [];

  void addDay(Day day) {
    days?.add(day);
  }

  void removeDay(Day day) {
    days?.remove(day);
  }

  Day getDay(int index) {
    return days![index];
  }
}

class Day {
  int dayIndex;
  List<Workout>? workouts;

  Day({
    this.dayIndex = 0,
    List<Workout>? workouts,
  }) : workouts = workouts ?? [];

  void addWorkout(Workout workout) {
    workouts?.add(workout);
  }

  void removeWorkout(Workout workout) {
    workouts?.remove(workout);
  }

  Workout getWorkout(int index) {
    return workouts![index];
  }
}

class Workout {
  String? name;
  double targetRpe;
  bool showE1rm;
  List<Set>? sets = [];

  Workout({
    this.name,
    this.targetRpe = 0,
    this.showE1rm = false,
    List<Set>? sets,
  }) : sets = sets ?? [];

  void addSet(Set set) {
    sets?.add(set);
  }

  void removeSet(Set set) {
    sets?.remove(set);
  }

  void emptySetsList() {
    sets = [];
  }

  Set getSet(int index) {
    return sets![index];
  }

  void editTargetRpe(double value) {
    targetRpe = value;
  }
}

class Set {
  late int? setIndex;
  int reps;
  double weight;
  double rpe;
  double e1rm;
  bool setComplete;
  Function? onUpdate;

  Set({
    this.setIndex,
    this.reps = 0,
    this.rpe = 0,
    this.weight = 0,
    this.e1rm = 0,
    this.setComplete = false,
    this.onUpdate,
  });

  void _notifyUpdate() {
    if (onUpdate != null) {
      onUpdate!();
    }
  }

  void editReps(int value) {
    reps = value;
    _e1rmCal();
    _notifyUpdate();
  }

  void editWeight(double value) {
    weight = value;
    _e1rmCal();
    _notifyUpdate();
  }

  void editRpe(double value) {
    rpe = value;
    _e1rmCal();
    _notifyUpdate();
  }

  void editE1rm(double value) {
    if (value.isInfinite || value.isNaN || value.isNegative) {
      e1rm = 0;
      _notifyUpdate();
    } else {
      e1rm = value;
      _notifyUpdate();
    }
  }

  double _percentage(int reps, double rpe) {
    if (rpe <= 0 || reps <= 0) {
      return 0;
    }

    if (rpe > 10) {
      rpe = 10;
    }

    if (reps < 1 || rpe < 4) {
      return 0;
    }

    if (reps == 1 && rpe == 10) {
      return 100;
    }

    var x = (10 - rpe) + (reps - 1);
    if (x >= 16) {
      return 0;
    }
    var intersection = 2.92;

    if (x <= intersection) {
      var a = 0.347619;
      var b = -4.60714;
      var c = 99.9667;
      return a * x * x + b * x + c;
    }

    var m = -2.64249;
    var b = 97.0955;
    return m * x + b;
  }

  void _e1rmCal() {
    double result = _percentage(reps, rpe);
    double e1rm = weight / result * 100;

    editE1rm(e1rm);
  }

  void changedSetComp(bool value) {
    setComplete = value;
    _notifyUpdate();
  }
}
