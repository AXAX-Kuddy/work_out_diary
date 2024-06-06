import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

/// 루틴 데이터 베이스
@DriftDatabase(tables: [Routines])
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

  /// 모든 루틴들(운동종목, 세트 포함) 삭제
  Future<int> removeAllDataTables() async {
    final allData = allTables.toList();
    int totalDelete = 0;

    for (var data in allData) {
      totalDelete += await delete(data).go();
    }
    return totalDelete;
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

/// 오늘 완료한 루틴, 루틴 저장소에 종속되어야 함
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routineName => text()();
  DateTimeColumn get date => dateTime()();

  BoolColumn get isFavor => boolean().withDefault(const Constant(false))();
  TextColumn get children => text()();
}
