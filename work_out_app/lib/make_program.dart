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
  List<Set>? sets = [];

  Workout({
    this.name,
    List<Set>? sets,
  }) : sets = sets ?? [];

  void addSet(Set set) {
    sets?.add(set);
  }

  void removeSet(Set set) {
    sets?.remove(set);
  }

  Set getSet(int index) {
    return sets![index];
  }
}

class Set {
  int setNum;
  int? reps;
  double? weight;
  double? rpe;

  Set({
    required this.setNum,
    this.reps,
    this.rpe,
    this.weight,
  });
}
