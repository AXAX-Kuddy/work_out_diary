import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class ChestList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨 벤치
      WorkoutMenuCompanion.insert(
        name: '벤치 프레스',
        showE1rm: const Value(true),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '정지 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '블럭 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '스포토 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '템포 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '하이핀 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '로우핀 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '벤치 스태틱 홀드',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '인클라인 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '디클라인 벤치 프레스',
        part: WorkoutListKeys.chest,
      ),

      /// 덤벨 벤치
      WorkoutMenuCompanion.insert(
        name: '인클라인 덤벨 프레스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '디클라인 덤벨 프레스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 플라이',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '디클라인 플라이',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 스퀴즈 프레스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),

      WorkoutMenuCompanion.insert(
        name: '중량 푸시업',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '중량 딥스',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.chest,
      ),

      ///머신
      WorkoutMenuCompanion.insert(
        name: '머신 체스트 프레스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 인클라인 체스트 프레스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 디클라인 체스트 프레스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '어시스트 딥스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 시티드 딥스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),

      WorkoutMenuCompanion.insert(
        name: '케이블 크로스 오버',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 펙덱 플라이',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.chest,
      ),

      /// 맨몸
      WorkoutMenuCompanion.insert(
        name: '푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '인클라인 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '디클라인 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '파이크 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '아처 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '클랩 푸시업',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
      WorkoutMenuCompanion.insert(
        name: '딥스',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.chest,
      ),
    ];
  }
}
