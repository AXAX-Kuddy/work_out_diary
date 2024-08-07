import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class CardioList {
  static List<WorkoutMenuCompanion> get get {
    return [
      WorkoutMenuCompanion.insert(
        name: '런닝 머신',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
      WorkoutMenuCompanion.insert(
        name: '천국의 계단',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
      WorkoutMenuCompanion.insert(
        name: '달리기',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
      WorkoutMenuCompanion.insert(
        name: '걷기',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
      WorkoutMenuCompanion.insert(
        name: '싸이클',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
      WorkoutMenuCompanion.insert(
        name: '계단 오르내리기',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.cardio,
      ),
    ];
  }
}
