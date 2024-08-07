import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class ShoulderList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨
      WorkoutMenuCompanion.insert(
        name: '밀리터리 프레스',
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '랜드마인 프레스',
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 업라이트 로우',
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 슈러그',
        part: WorkoutListKeys.shoulder,
      ),

      /// 덤벨
      WorkoutMenuCompanion.insert(
        name: '덤벨 숄더 프레스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '아놀드 프레스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 업라이트 로우',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 레터럴 레이즈',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 프론트 레이즈',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 벤트오버 레터럴 레이즈',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 슈러그',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.shoulder,
      ),

      /// 머신
      WorkoutMenuCompanion.insert(
        name: '머신 숄더 프레스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '리버스 펙덱 플라이',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 레터럴 레이즈',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '케이블 레터럴 레이즈',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '페이스 풀',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 슈러그',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.shoulder,
      ),
    ];
  }
}
