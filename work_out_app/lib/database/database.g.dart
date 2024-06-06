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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [routines];
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

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
}
