import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

/// 루틴 데이터 베이스
@DriftDatabase(tables: [
  Routines,
  Workouts,
  WorkoutSets,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 저장된 모든 루틴 불러오기
  Future<List<Routine>> getRoutines() async {
    return await select(routines).get();
  }

  /// 선택한 운동 루틴 삭제
  Future<int> removeRoutine(Routine selectRoutine) async {
    /// 삭제할 루틴의 운동 종목들 불러오기
    final deleteWorkout = await (select(workouts)
          ..where((workout) => workout.routineId.equals(selectRoutine.id)))
        .get();

    /// 불러온 운동 종목들에 해당하는 모든 세트 및 운동 종목 삭제
    for (var workout in deleteWorkout) {
      await (delete(workoutSets)
            ..where((set) => set.workoutId.equals(workout.id)))
          .go();
      await delete(workouts).delete(workout);
    }

    /// 매개변수로 받은 루틴 삭제
    return await delete(routines).delete(selectRoutine);
  }

  /// 모든 루틴들(운동종목, 세트 포함) 삭제
  Future<int> removeAllDataTables() async {
    final allData = allTables.toList();
    int totalDelete = 0;

    for (var data in allData) {
      totalDelete += await delete(data).go();
    }
    return totalDelete;
  }

  Future<int> insertWorkout(Insertable<Workout> workout) =>
      into(workouts).insert(workout);

  Future<int> insertSet(Insertable<WorkoutSet> set) =>
      into(workoutSets).insert(set);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}

/// 오늘 완료한 루틴, 루틴 저장소에 종속되어야 함
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routineName => text().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  BoolColumn get isFavor => boolean().withDefault(const Constant(false))();
}

///루틴 안 운동, 루틴에 종속되어야 함
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId => integer().nullable().references(Routines, #id)();
  TextColumn get name => text().nullable()();
  RealColumn get targetRpe => real().withDefault(const Constant(0))();
  BoolColumn get showE1rm => boolean().withDefault(const Constant(false))();
}

/// 운동 안 세트, 운동에 종속되어야 함
class WorkoutSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().nullable().references(Workouts, #id)();

  IntColumn get setIndex => integer().nullable()();
  RealColumn get weight => real().withDefault(const Constant(0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  RealColumn get rpe => real().withDefault(const Constant(0))();
  RealColumn get e1rm => real().withDefault(const Constant(0))();
  BoolColumn get setComplete => boolean().withDefault(const Constant(false))();
}
