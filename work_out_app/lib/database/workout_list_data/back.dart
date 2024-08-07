import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class BackList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨
      WorkoutMenuCompanion.insert(
        name: '바벨 로우',
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '펜들레이 로우',
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '굿 모닝',
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '씰 로우',
        part: WorkoutListKeys.back,
      ),

      /// 덤벨
      WorkoutMenuCompanion.insert(
        name: '덤벨 로우',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '원 암 덤벨 로우',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '인클라인 덤벨 로우',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '크록 로우',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 풀 오버',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '중량 풀업',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '중량 백 익스텐션',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.back,
      ),

      /// 머신
      WorkoutMenuCompanion.insert(
        name: '랫 풀 다운',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 시티드 로우',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 체스트 서포트 로우',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '케이블 시티드 로우',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '케이블 풀 오버',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '어시스트 풀업',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.back,
      ),

      /// 맨몸
      WorkoutMenuCompanion.insert(
        name: '풀업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '백 익스텐션',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.back,
      ),
      WorkoutMenuCompanion.insert(
        name: '인버티드 로우',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.back,
      ),
    ];
  }
}
