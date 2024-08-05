import 'package:drift/drift.dart';
import 'package:work_out_app/provider/make_program.dart';
import 'package:work_out_app/util/keys.dart';
import '../database.dart';

class ChestList {
  static List<WorkoutMenuCompanion> get get {
    return [
      /// 바벨 벤치
      WorkoutMenuCompanion.insert(
        name: '바벨 벤치 프레스',
        showE1rm: const Value(true),
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
    ];
  }
}
