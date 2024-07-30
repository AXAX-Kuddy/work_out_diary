import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:work_out_app/util/keys.dart';

part 'database.g.dart';

/// 루틴 데이터 베이스
@DriftDatabase(tables: [
  Routines,
  WorkoutMenu,
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
    /// 매개변수로 받은 루틴 삭제
    return await delete(routines).delete(selectRoutine);
  }

  Future<int> updateRoutine({required Routine selectRoutine, required  RoutinesCompanion companion}) async {
    return (update(routines)
          ..where(
            (tbl) => tbl.id.equals(selectRoutine.id),
          ))
        .write(
      companion
    );
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

  Future<List<WorkoutMenuData>> getAllWorkoutMenu() async {
    return select(workoutMenu).get();
  }

  Future<List<WorkoutMenuData>> getWorkoutMenusByPart(WorkoutListKeys part) {
    return (select(workoutMenu)
          ..where(
            (tbl) => tbl.part.equals(part.toString()),
          ))
        .get();
  }

  ///운동 종목 삽입
  Future insertWorkoutMenu(Insertable<WorkoutMenuData> data) async {
    into(workoutMenu).insert(data);
  }

  ///앱 최초 실행 시 운동목록 삽입
  Future<void> insertInitialData(AppDatabase db) async {
    final initialData = {
      WorkoutListKeys.leg: [
        WorkoutMenuCompanion.insert(
          name: '스쿼트',
          showE1rm: const Value(true),
          part: WorkoutListKeys.leg,
        ),
        WorkoutMenuCompanion.insert(
          name: '데드리프트',
          showE1rm: const Value(true),
          part: WorkoutListKeys.leg,
        ),
      ],
      WorkoutListKeys.back: [
        WorkoutMenuCompanion.insert(
          name: '랫 풀 다운',
          part: WorkoutListKeys.back,
        ),
        WorkoutMenuCompanion.insert(
          name: '바벨 로우',
          part: WorkoutListKeys.back,
        ),
      ],
      WorkoutListKeys.chest: [
        WorkoutMenuCompanion.insert(
          name: '바벨 벤치 프레스',
          showE1rm: const Value(true),
          part: WorkoutListKeys.chest,
        ),
        WorkoutMenuCompanion.insert(
          name: '인클라인 덤벨 프레스',
          part: WorkoutListKeys.chest,
        ),
      ],
      WorkoutListKeys.shoulder: [
        WorkoutMenuCompanion.insert(
          name: '바벨 밀리터리 프레스',
          part: WorkoutListKeys.shoulder,
        ),
        WorkoutMenuCompanion.insert(
          name: '사이드 레터럴 레이즈',
          part: WorkoutListKeys.shoulder,
        ),
      ],
      WorkoutListKeys.biceps: [
        WorkoutMenuCompanion.insert(
          name: '바벨 컬',
          part: WorkoutListKeys.biceps,
        ),
        WorkoutMenuCompanion.insert(
          name: '해머 컬',
          part: WorkoutListKeys.biceps,
        ),
      ],
      WorkoutListKeys.triceps: [
        WorkoutMenuCompanion.insert(
          name: '클로즈 그립 벤치프레스',
          part: WorkoutListKeys.triceps,
        ),
        WorkoutMenuCompanion.insert(
          name: '덤벨 스컬 크러셔',
          part: WorkoutListKeys.triceps,
        ),
      ],
    };

    for (var entry in initialData.entries) {
      for (var data in entry.value) {
        await db.insertWorkoutMenu(data);
      }
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    /// 데이터베이스 초기화
    /// 개발 중 데이터베이스 스키마의 변화가 생겼을 경우 사용
    // if (await file.exists()) {
    //   await file.delete();
    // }

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}

/// 오늘 완료한 루틴
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routineName => text()();
  DateTimeColumn get date => dateTime()();

  BoolColumn get isFavor => boolean().withDefault(const Constant(false))();
  TextColumn get children => text()();
}

class WorkoutListKeysConverter extends TypeConverter<WorkoutListKeys, String> {
  const WorkoutListKeysConverter();

  @override
  WorkoutListKeys fromSql(String fromDb) {
    return WorkoutListKeys.values.firstWhere((key) => key.toString() == fromDb);
  }

  @override
  String toSql(WorkoutListKeys value) {
    return value.toString();
  }
}

/// 운동 종목 리스트
class WorkoutMenu extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get memo => text().nullable()();
  BoolColumn get showE1rm => boolean().withDefault(const Constant(false))();
  TextColumn get part => text().map(const WorkoutListKeysConverter())();
}
