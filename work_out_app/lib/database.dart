import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

/// 루틴 데이터 베이스 임당
@DriftDatabase(tables: [RoutineStorage, Routines, Workouts, WorkoutSets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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

/// 사용자가 저장한 루틴 db
class RoutineStorage extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get storageName =>
      text().withDefault(const Constant('RoutineStorage'))();
}

/// 오늘 완료한 루틴, 루틴 저장소에 종속되어야 함
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storageId =>
      integer().customConstraint('REFERENCES routine_storage(id)').nullable()();

  DateTimeColumn get date => dateTime().nullable()();
  BoolColumn get isFavor => boolean().withDefault(const Constant(false))();
}

///루틴 안 운동, 루틴에 종속되어야 함
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId =>
      integer().customConstraint('REFERENCES routines(id)').nullable()();

  TextColumn get name => text().nullable()();
  RealColumn get targetRpe => real().withDefault(const Constant(0))();
  BoolColumn get showE1rm => boolean().withDefault(const Constant(false))();
}

/// 운동 안 세트, 운동에 종속되어야 함
class WorkoutSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId =>
      integer().customConstraint('REFERENCES workouts(id)').nullable()();

  IntColumn get setIndex => integer().nullable()();
  RealColumn get weight => real().withDefault(const Constant(0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  RealColumn get rpe => real().withDefault(const Constant(0))();
  RealColumn get e1rm => real().withDefault(const Constant(0))();
  BoolColumn get setComplete => boolean().withDefault(const Constant(false))();
}
