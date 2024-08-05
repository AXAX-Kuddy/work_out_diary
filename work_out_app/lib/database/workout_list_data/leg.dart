import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class LegList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨 스쿼트
      WorkoutMenuCompanion.insert(
        name: '바벨 백 스쿼트',
        showE1rm: const Value(true),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 정지 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 템포 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '프론트 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '저쳐 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 불가리안 스플릿 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 점프 스쿼트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 런지',
        part: WorkoutListKeys.leg,
      ),

      /// 바벨 데드리프트
      WorkoutMenuCompanion.insert(
        name: '컨벤셔널 데드리프트',
        showE1rm: const Value(true),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '스모 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '정지 컨벤셔널 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '정지 스모 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '템포 컨벤셔널 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '템포 스모 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '루마니안 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '스티프 레그 데드리프트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '바벨 힙 쓰러스트',
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '트랩바 데드리프트',
        part: WorkoutListKeys.leg,
      ),

      /// 덤벨 스쿼트
      WorkoutMenuCompanion.insert(
        name: '덤벨 불가리안 스플릿 스쿼트',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 런지',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 고블릿 스쿼트',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.leg,
      ),

      /// 덤벨 데드리프트
      WorkoutMenuCompanion.insert(
        name: '덤벨 루마니안 데드리프트',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '덤벨 시티프 레그 데드리프트',
        exerciseType: Value(ExerciseType.dumbbell),
        part: WorkoutListKeys.leg,
      ),

      /// 머신
      WorkoutMenuCompanion.insert(
        name: '파워 레그 프레스',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '레그 익스텐션',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '레그 컬',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '시티드 레그 컬',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '핵 스쿼트',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '브이 스쿼트',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '힙 어브덕션',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '이너 싸이',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 힙 쓰러스트',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '머신 카프레이즈',
        exerciseType: Value(ExerciseType.machine),
        part: WorkoutListKeys.leg,
      ),

      /// 맨몸
      WorkoutMenuCompanion.insert(
        name: '맨몸 스쿼트',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '맨몸 스플릿 스쿼트',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '맨몸 카프레이즈',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '맨몸 런지',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.leg,
      ),
      WorkoutMenuCompanion.insert(
        name: '피스톨 스쿼트',
        exerciseType: Value(ExerciseType.bodyweight),
        part: WorkoutListKeys.leg,
      ),
    ];
  }
}
