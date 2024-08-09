// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _routineNameMeta =
      const VerificationMeta('routineName');
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
      'routine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isFavorMeta =
      const VerificationMeta('isFavor');
  @override
  late final GeneratedColumn<bool> isFavor = GeneratedColumn<bool>(
      'is_favor', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favor" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _childrenMeta =
      const VerificationMeta('children');
  @override
  late final GeneratedColumn<String> children = GeneratedColumn<String>(
      'children', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, routineName, date, isFavor, children];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(Insertable<Routine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_name')) {
      context.handle(
          _routineNameMeta,
          routineName.isAcceptableOrUnknown(
              data['routine_name']!, _routineNameMeta));
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_favor')) {
      context.handle(_isFavorMeta,
          isFavor.isAcceptableOrUnknown(data['is_favor']!, _isFavorMeta));
    }
    if (data.containsKey('children')) {
      context.handle(_childrenMeta,
          children.isAcceptableOrUnknown(data['children']!, _childrenMeta));
    } else if (isInserting) {
      context.missing(_childrenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      routineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_name'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isFavor: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favor'])!,
      children: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}children'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final String routineName;
  final DateTime date;
  final bool isFavor;
  final String children;
  const Routine(
      {required this.id,
      required this.routineName,
      required this.date,
      required this.isFavor,
      required this.children});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_name'] = Variable<String>(routineName);
    map['date'] = Variable<DateTime>(date);
    map['is_favor'] = Variable<bool>(isFavor);
    map['children'] = Variable<String>(children);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      routineName: Value(routineName),
      date: Value(date),
      isFavor: Value(isFavor),
      children: Value(children),
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      routineName: serializer.fromJson<String>(json['routineName']),
      date: serializer.fromJson<DateTime>(json['date']),
      isFavor: serializer.fromJson<bool>(json['isFavor']),
      children: serializer.fromJson<String>(json['children']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineName': serializer.toJson<String>(routineName),
      'date': serializer.toJson<DateTime>(date),
      'isFavor': serializer.toJson<bool>(isFavor),
      'children': serializer.toJson<String>(children),
    };
  }

  Routine copyWith(
          {int? id,
          String? routineName,
          DateTime? date,
          bool? isFavor,
          String? children}) =>
      Routine(
        id: id ?? this.id,
        routineName: routineName ?? this.routineName,
        date: date ?? this.date,
        isFavor: isFavor ?? this.isFavor,
        children: children ?? this.children,
      );
  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor, ')
          ..write('children: $children')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineName, date, isFavor, children);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.routineName == this.routineName &&
          other.date == this.date &&
          other.isFavor == this.isFavor &&
          other.children == this.children);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<String> routineName;
  final Value<DateTime> date;
  final Value<bool> isFavor;
  final Value<String> children;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.routineName = const Value.absent(),
    this.date = const Value.absent(),
    this.isFavor = const Value.absent(),
    this.children = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String routineName,
    required DateTime date,
    this.isFavor = const Value.absent(),
    required String children,
  })  : routineName = Value(routineName),
        date = Value(date),
        children = Value(children);
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<String>? routineName,
    Expression<DateTime>? date,
    Expression<bool>? isFavor,
    Expression<String>? children,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineName != null) 'routine_name': routineName,
      if (date != null) 'date': date,
      if (isFavor != null) 'is_favor': isFavor,
      if (children != null) 'children': children,
    });
  }

  RoutinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? routineName,
      Value<DateTime>? date,
      Value<bool>? isFavor,
      Value<String>? children}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      routineName: routineName ?? this.routineName,
      date: date ?? this.date,
      isFavor: isFavor ?? this.isFavor,
      children: children ?? this.children,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isFavor.present) {
      map['is_favor'] = Variable<bool>(isFavor.value);
    }
    if (children.present) {
      map['children'] = Variable<String>(children.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor, ')
          ..write('children: $children')
          ..write(')'))
        .toString();
  }
}

class $WorkoutMenuTable extends WorkoutMenu
    with TableInfo<$WorkoutMenuTable, WorkoutMenuData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutMenuTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseTypeMeta =
      const VerificationMeta('exerciseType');
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
      'exercise_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("Barbell"));
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _showE1rmMeta =
      const VerificationMeta('showE1rm');
  @override
  late final GeneratedColumn<bool> showE1rm = GeneratedColumn<bool>(
      'show_e1rm', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("show_e1rm" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutListKeys, String> part =
      GeneratedColumn<String>('part', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WorkoutListKeys>($WorkoutMenuTable.$converterpart);
  static const VerificationMeta _customMeta = const VerificationMeta('custom');
  @override
  late final GeneratedColumn<bool> custom = GeneratedColumn<bool>(
      'custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("custom" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, exerciseType, memo, showE1rm, part, custom];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_menu';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutMenuData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
          _exerciseTypeMeta,
          exerciseType.isAcceptableOrUnknown(
              data['exercise_type']!, _exerciseTypeMeta));
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('show_e1rm')) {
      context.handle(_showE1rmMeta,
          showE1rm.isAcceptableOrUnknown(data['show_e1rm']!, _showE1rmMeta));
    }
    context.handle(_partMeta, const VerificationResult.success());
    if (data.containsKey('custom')) {
      context.handle(_customMeta,
          custom.isAcceptableOrUnknown(data['custom']!, _customMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutMenuData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutMenuData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      exerciseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_type'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      showE1rm: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_e1rm'])!,
      part: $WorkoutMenuTable.$converterpart.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part'])!),
      custom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}custom'])!,
    );
  }

  @override
  $WorkoutMenuTable createAlias(String alias) {
    return $WorkoutMenuTable(attachedDatabase, alias);
  }

  static TypeConverter<WorkoutListKeys, String> $converterpart =
      const WorkoutListKeysConverter();
}

class WorkoutMenuData extends DataClass implements Insertable<WorkoutMenuData> {
  final int id;
  final String name;
  final String exerciseType;
  final String? memo;
  final bool showE1rm;
  final WorkoutListKeys part;
  final bool custom;
  const WorkoutMenuData(
      {required this.id,
      required this.name,
      required this.exerciseType,
      this.memo,
      required this.showE1rm,
      required this.part,
      required this.custom});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['exercise_type'] = Variable<String>(exerciseType);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['show_e1rm'] = Variable<bool>(showE1rm);
    {
      map['part'] =
          Variable<String>($WorkoutMenuTable.$converterpart.toSql(part));
    }
    map['custom'] = Variable<bool>(custom);
    return map;
  }

  WorkoutMenuCompanion toCompanion(bool nullToAbsent) {
    return WorkoutMenuCompanion(
      id: Value(id),
      name: Value(name),
      exerciseType: Value(exerciseType),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      showE1rm: Value(showE1rm),
      part: Value(part),
      custom: Value(custom),
    );
  }

  factory WorkoutMenuData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutMenuData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      memo: serializer.fromJson<String?>(json['memo']),
      showE1rm: serializer.fromJson<bool>(json['showE1rm']),
      part: serializer.fromJson<WorkoutListKeys>(json['part']),
      custom: serializer.fromJson<bool>(json['custom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'exerciseType': serializer.toJson<String>(exerciseType),
      'memo': serializer.toJson<String?>(memo),
      'showE1rm': serializer.toJson<bool>(showE1rm),
      'part': serializer.toJson<WorkoutListKeys>(part),
      'custom': serializer.toJson<bool>(custom),
    };
  }

  WorkoutMenuData copyWith(
          {int? id,
          String? name,
          String? exerciseType,
          Value<String?> memo = const Value.absent(),
          bool? showE1rm,
          WorkoutListKeys? part,
          bool? custom}) =>
      WorkoutMenuData(
        id: id ?? this.id,
        name: name ?? this.name,
        exerciseType: exerciseType ?? this.exerciseType,
        memo: memo.present ? memo.value : this.memo,
        showE1rm: showE1rm ?? this.showE1rm,
        part: part ?? this.part,
        custom: custom ?? this.custom,
      );
  @override
  String toString() {
    return (StringBuffer('WorkoutMenuData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('memo: $memo, ')
          ..write('showE1rm: $showE1rm, ')
          ..write('part: $part, ')
          ..write('custom: $custom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, exerciseType, memo, showE1rm, part, custom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutMenuData &&
          other.id == this.id &&
          other.name == this.name &&
          other.exerciseType == this.exerciseType &&
          other.memo == this.memo &&
          other.showE1rm == this.showE1rm &&
          other.part == this.part &&
          other.custom == this.custom);
}

class WorkoutMenuCompanion extends UpdateCompanion<WorkoutMenuData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> exerciseType;
  final Value<String?> memo;
  final Value<bool> showE1rm;
  final Value<WorkoutListKeys> part;
  final Value<bool> custom;
  const WorkoutMenuCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.memo = const Value.absent(),
    this.showE1rm = const Value.absent(),
    this.part = const Value.absent(),
    this.custom = const Value.absent(),
  });
  WorkoutMenuCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.exerciseType = const Value.absent(),
    this.memo = const Value.absent(),
    this.showE1rm = const Value.absent(),
    required WorkoutListKeys part,
    this.custom = const Value.absent(),
  })  : name = Value(name),
        part = Value(part);
  static Insertable<WorkoutMenuData> createCustom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? exerciseType,
    Expression<String>? memo,
    Expression<bool>? showE1rm,
    Expression<String>? part,
    Expression<bool>? custom,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (memo != null) 'memo': memo,
      if (showE1rm != null) 'show_e1rm': showE1rm,
      if (part != null) 'part': part,
      if (custom != null) 'custom': custom,
    });
  }

  WorkoutMenuCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? exerciseType,
      Value<String?>? memo,
      Value<bool>? showE1rm,
      Value<WorkoutListKeys>? part,
      Value<bool>? custom}) {
    return WorkoutMenuCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseType: exerciseType ?? this.exerciseType,
      memo: memo ?? this.memo,
      showE1rm: showE1rm ?? this.showE1rm,
      part: part ?? this.part,
      custom: custom ?? this.custom,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (showE1rm.present) {
      map['show_e1rm'] = Variable<bool>(showE1rm.value);
    }
    if (part.present) {
      map['part'] =
          Variable<String>($WorkoutMenuTable.$converterpart.toSql(part.value));
    }
    if (custom.present) {
      map['custom'] = Variable<bool>(custom.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutMenuCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('memo: $memo, ')
          ..write('showE1rm: $showE1rm, ')
          ..write('part: $part, ')
          ..write('custom: $custom')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $WorkoutMenuTable workoutMenu = $WorkoutMenuTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [routines, workoutMenu];
}

typedef $$RoutinesTableInsertCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  required String routineName,
  required DateTime date,
  Value<bool> isFavor,
  required String children,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<String> routineName,
  Value<DateTime> date,
  Value<bool> isFavor,
  Value<String> children,
});

class $$RoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutinesTable,
    Routine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableProcessedTableManager,
    $$RoutinesTableInsertCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder> {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RoutinesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RoutinesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$RoutinesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> routineName = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isFavor = const Value.absent(),
            Value<String> children = const Value.absent(),
          }) =>
              RoutinesCompanion(
            id: id,
            routineName: routineName,
            date: date,
            isFavor: isFavor,
            children: children,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String routineName,
            required DateTime date,
            Value<bool> isFavor = const Value.absent(),
            required String children,
          }) =>
              RoutinesCompanion.insert(
            id: id,
            routineName: routineName,
            date: date,
            isFavor: isFavor,
            children: children,
          ),
        ));
}

class $$RoutinesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RoutinesTable,
    Routine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableProcessedTableManager,
    $$RoutinesTableInsertCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder> {
  $$RoutinesTableProcessedTableManager(super.$state);
}

class $$RoutinesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get routineName => $state.composableBuilder(
      column: $state.table.routineName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFavor => $state.composableBuilder(
      column: $state.table.isFavor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get children => $state.composableBuilder(
      column: $state.table.children,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RoutinesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get routineName => $state.composableBuilder(
      column: $state.table.routineName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFavor => $state.composableBuilder(
      column: $state.table.isFavor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get children => $state.composableBuilder(
      column: $state.table.children,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WorkoutMenuTableInsertCompanionBuilder = WorkoutMenuCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String> exerciseType,
  Value<String?> memo,
  Value<bool> showE1rm,
  required WorkoutListKeys part,
  Value<bool> custom,
});
typedef $$WorkoutMenuTableUpdateCompanionBuilder = WorkoutMenuCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> exerciseType,
  Value<String?> memo,
  Value<bool> showE1rm,
  Value<WorkoutListKeys> part,
  Value<bool> custom,
});

class $$WorkoutMenuTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutMenuTable,
    WorkoutMenuData,
    $$WorkoutMenuTableFilterComposer,
    $$WorkoutMenuTableOrderingComposer,
    $$WorkoutMenuTableProcessedTableManager,
    $$WorkoutMenuTableInsertCompanionBuilder,
    $$WorkoutMenuTableUpdateCompanionBuilder> {
  $$WorkoutMenuTableTableManager(_$AppDatabase db, $WorkoutMenuTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkoutMenuTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkoutMenuTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkoutMenuTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> exerciseType = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<bool> showE1rm = const Value.absent(),
            Value<WorkoutListKeys> part = const Value.absent(),
            Value<bool> custom = const Value.absent(),
          }) =>
              WorkoutMenuCompanion(
            id: id,
            name: name,
            exerciseType: exerciseType,
            memo: memo,
            showE1rm: showE1rm,
            part: part,
            custom: custom,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> exerciseType = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<bool> showE1rm = const Value.absent(),
            required WorkoutListKeys part,
            Value<bool> custom = const Value.absent(),
          }) =>
              WorkoutMenuCompanion.insert(
            id: id,
            name: name,
            exerciseType: exerciseType,
            memo: memo,
            showE1rm: showE1rm,
            part: part,
            custom: custom,
          ),
        ));
}

class $$WorkoutMenuTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkoutMenuTable,
    WorkoutMenuData,
    $$WorkoutMenuTableFilterComposer,
    $$WorkoutMenuTableOrderingComposer,
    $$WorkoutMenuTableProcessedTableManager,
    $$WorkoutMenuTableInsertCompanionBuilder,
    $$WorkoutMenuTableUpdateCompanionBuilder> {
  $$WorkoutMenuTableProcessedTableManager(super.$state);
}

class $$WorkoutMenuTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkoutMenuTable> {
  $$WorkoutMenuTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get exerciseType => $state.composableBuilder(
      column: $state.table.exerciseType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get memo => $state.composableBuilder(
      column: $state.table.memo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get showE1rm => $state.composableBuilder(
      column: $state.table.showE1rm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<WorkoutListKeys, WorkoutListKeys, String>
      get part => $state.composableBuilder(
          column: $state.table.part,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<bool> get custom => $state.composableBuilder(
      column: $state.table.custom,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WorkoutMenuTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkoutMenuTable> {
  $$WorkoutMenuTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get exerciseType => $state.composableBuilder(
      column: $state.table.exerciseType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get memo => $state.composableBuilder(
      column: $state.table.memo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get showE1rm => $state.composableBuilder(
      column: $state.table.showE1rm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get part => $state.composableBuilder(
      column: $state.table.part,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get custom => $state.composableBuilder(
      column: $state.table.custom,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$WorkoutMenuTableTableManager get workoutMenu =>
      $$WorkoutMenuTableTableManager(_db, _db.workoutMenu);
}
