import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class TricepsList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨
      WorkoutMenuCompanion.insert(
        name: '클로즈 그립 벤치프레스',
        part: WorkoutListKeys.triceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '스컬 크러셔',
        part: WorkoutListKeys.triceps,
      ),

      /// 덤벨
      WorkoutMenuCompanion.insert(
        name: '덤벨 트라이셉스 익스텐션',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.triceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 스컬 크러셔',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.triceps,
      ),

      /// 머신
      WorkoutMenuCompanion.insert(
        name: '케이블 푸시 다운',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.triceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '케이블 트라이셉스 익스텐션',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.triceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 트라이셉스 익스텐션',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.triceps,
      ),

      ///맨몸
      WorkoutMenuCompanion.insert(
        name: '클로즈 그립 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.triceps,
      ),
      WorkoutMenuCompanion.insert(
        name: '벤치 딥스',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.triceps,
      ),
    ];
  }
}
