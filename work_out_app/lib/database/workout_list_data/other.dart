import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class OtherList {
  static List<WorkoutMenuCompanion> get get {
    return [

      

      WorkoutMenuCompanion.insert(
        name: '싯업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '디클라인 싯업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '레그 레이즈',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '행잉 레그 레이즈',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '플랭크',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '사이드 플랭크',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
      WorkoutMenuCompanion.insert(
        name: '크런치',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),
       WorkoutMenuCompanion.insert(
        name: '디클라인 크런치',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.other,
      ),


      /// 덤벨
       WorkoutMenuCompanion.insert(
        name: '중량 싯업',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.other,
      ),
        WorkoutMenuCompanion.insert(
        name: '중량 크런치',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.other,
      ),
    ];
  }
}
