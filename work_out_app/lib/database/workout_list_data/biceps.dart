import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class BicepsList {
  static List<WorkoutMenuCompanion> get get {
    return [
      ///바벨
      WorkoutMenuCompanion.insert(
        name: '바벨 컬',
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 프리쳐 컬',
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 리스트 컬',
        part: WorkoutListKeys.biceps,
      ),

      ///덤벨
      WorkoutMenuCompanion.insert(
        name: '덤벨 컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '인클라인 덤벨컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '컨센트레이션 컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '해머 컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 프리쳐 컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 리스트 컬',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.biceps,
      ),

      ///머신
      WorkoutMenuCompanion.insert(
        name: '케이블 컬',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 프리쳐 컬',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.biceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '케이블 해머 컬',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.biceps,
      ),

      /// 기타
      WorkoutMenuCompanion.insert(
        name: '추감기',
        exerciseType: Value(ExerciseType.other),
        part: WorkoutListKeys.biceps,
      ),
    ];
  }
}
