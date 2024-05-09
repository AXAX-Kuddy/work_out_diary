// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RoutineStorageTable extends RoutineStorage
    with TableInfo<$RoutineStorageTable, RoutineStorage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineStorageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storageNameMeta =
      const VerificationMeta('storageName');
  @override
  late final GeneratedColumn<String> storageName = GeneratedColumn<String>(
      'storage_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('RoutineStorage'));
  @override
  List<GeneratedColumn> get $columns => [id, storageName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_storage';
  @override
  VerificationContext validateIntegrity(Insertable<RoutineStorage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('storage_name')) {
      context.handle(
          _storageNameMeta,
          storageName.isAcceptableOrUnknown(
              data['storage_name']!, _storageNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineStorage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineStorage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_name'])!,
    );
  }

  @override
  $RoutineStorageTable createAlias(String alias) {
    return $RoutineStorageTable(attachedDatabase, alias);
  }
}

class RoutineStorage extends DataClass implements Insertable<RoutineStorage> {
  final int id;
  final String storageName;
  const RoutineStorage({required this.id, required this.storageName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['storage_name'] = Variable<String>(storageName);
    return map;
  }

  RoutineStorageCompanion toCompanion(bool nullToAbsent) {
    return RoutineStorageCompanion(
      id: Value(id),
      storageName: Value(storageName),
    );
  }

  factory RoutineStorage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineStorage(
      id: serializer.fromJson<int>(json['id']),
      storageName: serializer.fromJson<String>(json['storageName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storageName': serializer.toJson<String>(storageName),
    };
  }

  RoutineStorage copyWith({int? id, String? storageName}) => RoutineStorage(
        id: id ?? this.id,
        storageName: storageName ?? this.storageName,
      );
  @override
  String toString() {
    return (StringBuffer('RoutineStorage(')
          ..write('id: $id, ')
          ..write('storageName: $storageName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storageName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineStorage &&
          other.id == this.id &&
          other.storageName == this.storageName);
}

class RoutineStorageCompanion extends UpdateCompanion<RoutineStorage> {
  final Value<int> id;
  final Value<String> storageName;
  const RoutineStorageCompanion({
    this.id = const Value.absent(),
    this.storageName = const Value.absent(),
  });
  RoutineStorageCompanion.insert({
    this.id = const Value.absent(),
    this.storageName = const Value.absent(),
  });
  static Insertable<RoutineStorage> custom({
    Expression<int>? id,
    Expression<String>? storageName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storageName != null) 'storage_name': storageName,
    });
  }

  RoutineStorageCompanion copyWith(
      {Value<int>? id, Value<String>? storageName}) {
    return RoutineStorageCompanion(
      id: id ?? this.id,
      storageName: storageName ?? this.storageName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storageName.present) {
      map['storage_name'] = Variable<String>(storageName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineStorageCompanion(')
          ..write('id: $id, ')
          ..write('storageName: $storageName')
          ..write(')'))
        .toString();
  }
}

class $RoutineTable extends Routine with TableInfo<$RoutineTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _storageIdMeta =
      const VerificationMeta('storageId');
  @override
  late final GeneratedColumn<int> storageId = GeneratedColumn<int>(
      'storage_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES routine_storage(id)');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
  @override
  List<GeneratedColumn> get $columns => [id, storageId, date, isFavor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine';
  @override
  VerificationContext validateIntegrity(Insertable<Routine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('storage_id')) {
      context.handle(_storageIdMeta,
          storageId.isAcceptableOrUnknown(data['storage_id']!, _storageIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('is_favor')) {
      context.handle(_isFavorMeta,
          isFavor.isAcceptableOrUnknown(data['is_favor']!, _isFavorMeta));
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
      storageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}storage_id']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      isFavor: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favor'])!,
    );
  }

  @override
  $RoutineTable createAlias(String alias) {
    return $RoutineTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final int? storageId;
  final DateTime? date;
  final bool isFavor;
  const Routine(
      {required this.id, this.storageId, this.date, required this.isFavor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || storageId != null) {
      map['storage_id'] = Variable<int>(storageId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    map['is_favor'] = Variable<bool>(isFavor);
    return map;
  }

  RoutineCompanion toCompanion(bool nullToAbsent) {
    return RoutineCompanion(
      id: Value(id),
      storageId: storageId == null && nullToAbsent
          ? const Value.absent()
          : Value(storageId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      isFavor: Value(isFavor),
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      storageId: serializer.fromJson<int?>(json['storageId']),
      date: serializer.fromJson<DateTime?>(json['date']),
      isFavor: serializer.fromJson<bool>(json['isFavor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storageId': serializer.toJson<int?>(storageId),
      'date': serializer.toJson<DateTime?>(date),
      'isFavor': serializer.toJson<bool>(isFavor),
    };
  }

  Routine copyWith(
          {int? id,
          Value<int?> storageId = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          bool? isFavor}) =>
      Routine(
        id: id ?? this.id,
        storageId: storageId.present ? storageId.value : this.storageId,
        date: date.present ? date.value : this.date,
        isFavor: isFavor ?? this.isFavor,
      );
  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('storageId: $storageId, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storageId, date, isFavor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.storageId == this.storageId &&
          other.date == this.date &&
          other.isFavor == this.isFavor);
}

class RoutineCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<int?> storageId;
  final Value<DateTime?> date;
  final Value<bool> isFavor;
  const RoutineCompanion({
    this.id = const Value.absent(),
    this.storageId = const Value.absent(),
    this.date = const Value.absent(),
    this.isFavor = const Value.absent(),
  });
  RoutineCompanion.insert({
    this.id = const Value.absent(),
    this.storageId = const Value.absent(),
    this.date = const Value.absent(),
    this.isFavor = const Value.absent(),
  });
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<int>? storageId,
    Expression<DateTime>? date,
    Expression<bool>? isFavor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storageId != null) 'storage_id': storageId,
      if (date != null) 'date': date,
      if (isFavor != null) 'is_favor': isFavor,
    });
  }

  RoutineCompanion copyWith(
      {Value<int>? id,
      Value<int?>? storageId,
      Value<DateTime?>? date,
      Value<bool>? isFavor}) {
    return RoutineCompanion(
      id: id ?? this.id,
      storageId: storageId ?? this.storageId,
      date: date ?? this.date,
      isFavor: isFavor ?? this.isFavor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storageId.present) {
      map['storage_id'] = Variable<int>(storageId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isFavor.present) {
      map['is_favor'] = Variable<bool>(isFavor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineCompanion(')
          ..write('id: $id, ')
          ..write('storageId: $storageId, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workouts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
      'routine_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES routine(id)');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetRpeMeta =
      const VerificationMeta('targetRpe');
  @override
  late final GeneratedColumn<double> targetRpe = GeneratedColumn<double>(
      'target_rpe', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, routineId, name, targetRpe, showE1rm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workouts> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('target_rpe')) {
      context.handle(_targetRpeMeta,
          targetRpe.isAcceptableOrUnknown(data['target_rpe']!, _targetRpeMeta));
    }
    if (data.containsKey('show_e1rm')) {
      context.handle(_showE1rmMeta,
          showE1rm.isAcceptableOrUnknown(data['show_e1rm']!, _showE1rmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workouts map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workouts(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}routine_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      targetRpe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_rpe'])!,
      showE1rm: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_e1rm'])!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workouts extends DataClass implements Insertable<Workouts> {
  final int id;
  final int? routineId;
  final String? name;
  final double targetRpe;
  final bool showE1rm;
  const Workouts(
      {required this.id,
      this.routineId,
      this.name,
      required this.targetRpe,
      required this.showE1rm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<int>(routineId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['target_rpe'] = Variable<double>(targetRpe);
    map['show_e1rm'] = Variable<bool>(showE1rm);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      targetRpe: Value(targetRpe),
      showE1rm: Value(showE1rm),
    );
  }

  factory Workouts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workouts(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int?>(json['routineId']),
      name: serializer.fromJson<String?>(json['name']),
      targetRpe: serializer.fromJson<double>(json['targetRpe']),
      showE1rm: serializer.fromJson<bool>(json['showE1rm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<int?>(routineId),
      'name': serializer.toJson<String?>(name),
      'targetRpe': serializer.toJson<double>(targetRpe),
      'showE1rm': serializer.toJson<bool>(showE1rm),
    };
  }

  Workouts copyWith(
          {int? id,
          Value<int?> routineId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          double? targetRpe,
          bool? showE1rm}) =>
      Workouts(
        id: id ?? this.id,
        routineId: routineId.present ? routineId.value : this.routineId,
        name: name.present ? name.value : this.name,
        targetRpe: targetRpe ?? this.targetRpe,
        showE1rm: showE1rm ?? this.showE1rm,
      );
  @override
  String toString() {
    return (StringBuffer('Workouts(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('showE1rm: $showE1rm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, name, targetRpe, showE1rm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workouts &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.targetRpe == this.targetRpe &&
          other.showE1rm == this.showE1rm);
}

class WorkoutsCompanion extends UpdateCompanion<Workouts> {
  final Value<int> id;
  final Value<int?> routineId;
  final Value<String?> name;
  final Value<double> targetRpe;
  final Value<bool> showE1rm;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.targetRpe = const Value.absent(),
    this.showE1rm = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.targetRpe = const Value.absent(),
    this.showE1rm = const Value.absent(),
  });
  static Insertable<Workouts> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<String>? name,
    Expression<double>? targetRpe,
    Expression<bool>? showE1rm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (name != null) 'name': name,
      if (targetRpe != null) 'target_rpe': targetRpe,
      if (showE1rm != null) 'show_e1rm': showE1rm,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? routineId,
      Value<String?>? name,
      Value<double>? targetRpe,
      Value<bool>? showE1rm}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      targetRpe: targetRpe ?? this.targetRpe,
      showE1rm: showE1rm ?? this.showE1rm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetRpe.present) {
      map['target_rpe'] = Variable<double>(targetRpe.value);
    }
    if (showE1rm.present) {
      map['show_e1rm'] = Variable<bool>(showE1rm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('targetRpe: $targetRpe, ')
          ..write('showE1rm: $showE1rm')
          ..write(')'))
        .toString();
  }
}

class $SetsTable extends Sets with TableInfo<$SetsTable, Sets> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES workouts(id)');
  static const VerificationMeta _setIndexMeta =
      const VerificationMeta('setIndex');
  @override
  late final GeneratedColumn<int> setIndex = GeneratedColumn<int>(
      'set_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
      'rpe', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _e1rmMeta = const VerificationMeta('e1rm');
  @override
  late final GeneratedColumn<double> e1rm = GeneratedColumn<double>(
      'e1rm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _setCompleteMeta =
      const VerificationMeta('setComplete');
  @override
  late final GeneratedColumn<bool> setComplete = GeneratedColumn<bool>(
      'set_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("set_complete" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutId, setIndex, weight, reps, rpe, e1rm, setComplete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sets';
  @override
  VerificationContext validateIntegrity(Insertable<Sets> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    }
    if (data.containsKey('set_index')) {
      context.handle(_setIndexMeta,
          setIndex.isAcceptableOrUnknown(data['set_index']!, _setIndexMeta));
    } else if (isInserting) {
      context.missing(_setIndexMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    } else if (isInserting) {
      context.missing(_rpeMeta);
    }
    if (data.containsKey('e1rm')) {
      context.handle(
          _e1rmMeta, e1rm.isAcceptableOrUnknown(data['e1rm']!, _e1rmMeta));
    } else if (isInserting) {
      context.missing(_e1rmMeta);
    }
    if (data.containsKey('set_complete')) {
      context.handle(
          _setCompleteMeta,
          setComplete.isAcceptableOrUnknown(
              data['set_complete']!, _setCompleteMeta));
    } else if (isInserting) {
      context.missing(_setCompleteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sets map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sets(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id']),
      setIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_index'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      rpe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rpe'])!,
      e1rm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}e1rm'])!,
      setComplete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}set_complete'])!,
    );
  }

  @override
  $SetsTable createAlias(String alias) {
    return $SetsTable(attachedDatabase, alias);
  }
}

class Sets extends DataClass implements Insertable<Sets> {
  final int id;
  final int? workoutId;
  final int setIndex;
  final double weight;
  final int reps;
  final double rpe;
  final double e1rm;
  final bool setComplete;
  const Sets(
      {required this.id,
      this.workoutId,
      required this.setIndex,
      required this.weight,
      required this.reps,
      required this.rpe,
      required this.e1rm,
      required this.setComplete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || workoutId != null) {
      map['workout_id'] = Variable<int>(workoutId);
    }
    map['set_index'] = Variable<int>(setIndex);
    map['weight'] = Variable<double>(weight);
    map['reps'] = Variable<int>(reps);
    map['rpe'] = Variable<double>(rpe);
    map['e1rm'] = Variable<double>(e1rm);
    map['set_complete'] = Variable<bool>(setComplete);
    return map;
  }

  SetsCompanion toCompanion(bool nullToAbsent) {
    return SetsCompanion(
      id: Value(id),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      setIndex: Value(setIndex),
      weight: Value(weight),
      reps: Value(reps),
      rpe: Value(rpe),
      e1rm: Value(e1rm),
      setComplete: Value(setComplete),
    );
  }

  factory Sets.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sets(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<int?>(json['workoutId']),
      setIndex: serializer.fromJson<int>(json['setIndex']),
      weight: serializer.fromJson<double>(json['weight']),
      reps: serializer.fromJson<int>(json['reps']),
      rpe: serializer.fromJson<double>(json['rpe']),
      e1rm: serializer.fromJson<double>(json['e1rm']),
      setComplete: serializer.fromJson<bool>(json['setComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutId': serializer.toJson<int?>(workoutId),
      'setIndex': serializer.toJson<int>(setIndex),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<int>(reps),
      'rpe': serializer.toJson<double>(rpe),
      'e1rm': serializer.toJson<double>(e1rm),
      'setComplete': serializer.toJson<bool>(setComplete),
    };
  }

  Sets copyWith(
          {int? id,
          Value<int?> workoutId = const Value.absent(),
          int? setIndex,
          double? weight,
          int? reps,
          double? rpe,
          double? e1rm,
          bool? setComplete}) =>
      Sets(
        id: id ?? this.id,
        workoutId: workoutId.present ? workoutId.value : this.workoutId,
        setIndex: setIndex ?? this.setIndex,
        weight: weight ?? this.weight,
        reps: reps ?? this.reps,
        rpe: rpe ?? this.rpe,
        e1rm: e1rm ?? this.e1rm,
        setComplete: setComplete ?? this.setComplete,
      );
  @override
  String toString() {
    return (StringBuffer('Sets(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('setIndex: $setIndex, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('e1rm: $e1rm, ')
          ..write('setComplete: $setComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workoutId, setIndex, weight, reps, rpe, e1rm, setComplete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sets &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.setIndex == this.setIndex &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.rpe == this.rpe &&
          other.e1rm == this.e1rm &&
          other.setComplete == this.setComplete);
}

class SetsCompanion extends UpdateCompanion<Sets> {
  final Value<int> id;
  final Value<int?> workoutId;
  final Value<int> setIndex;
  final Value<double> weight;
  final Value<int> reps;
  final Value<double> rpe;
  final Value<double> e1rm;
  final Value<bool> setComplete;
  const SetsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.e1rm = const Value.absent(),
    this.setComplete = const Value.absent(),
  });
  SetsCompanion.insert({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    required int setIndex,
    required double weight,
    required int reps,
    required double rpe,
    required double e1rm,
    required bool setComplete,
  })  : setIndex = Value(setIndex),
        weight = Value(weight),
        reps = Value(reps),
        rpe = Value(rpe),
        e1rm = Value(e1rm),
        setComplete = Value(setComplete);
  static Insertable<Sets> custom({
    Expression<int>? id,
    Expression<int>? workoutId,
    Expression<int>? setIndex,
    Expression<double>? weight,
    Expression<int>? reps,
    Expression<double>? rpe,
    Expression<double>? e1rm,
    Expression<bool>? setComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (setIndex != null) 'set_index': setIndex,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
      if (rpe != null) 'rpe': rpe,
      if (e1rm != null) 'e1rm': e1rm,
      if (setComplete != null) 'set_complete': setComplete,
    });
  }

  SetsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? workoutId,
      Value<int>? setIndex,
      Value<double>? weight,
      Value<int>? reps,
      Value<double>? rpe,
      Value<double>? e1rm,
      Value<bool>? setComplete}) {
    return SetsCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      setIndex: setIndex ?? this.setIndex,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      rpe: rpe ?? this.rpe,
      e1rm: e1rm ?? this.e1rm,
      setComplete: setComplete ?? this.setComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (setIndex.present) {
      map['set_index'] = Variable<int>(setIndex.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (e1rm.present) {
      map['e1rm'] = Variable<double>(e1rm.value);
    }
    if (setComplete.present) {
      map['set_complete'] = Variable<bool>(setComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('setIndex: $setIndex, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('e1rm: $e1rm, ')
          ..write('setComplete: $setComplete')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $RoutineStorageTable routineStorage = $RoutineStorageTable(this);
  late final $RoutineTable routine = $RoutineTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $SetsTable sets = $SetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [routineStorage, routine, workouts, sets];
}

typedef $$RoutineStorageTableInsertCompanionBuilder = RoutineStorageCompanion
    Function({
  Value<int> id,
  Value<String> storageName,
});
typedef $$RoutineStorageTableUpdateCompanionBuilder = RoutineStorageCompanion
    Function({
  Value<int> id,
  Value<String> storageName,
});

class $$RoutineStorageTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutineStorageTable,
    RoutineStorage,
    $$RoutineStorageTableFilterComposer,
    $$RoutineStorageTableOrderingComposer,
    $$RoutineStorageTableProcessedTableManager,
    $$RoutineStorageTableInsertCompanionBuilder,
    $$RoutineStorageTableUpdateCompanionBuilder> {
  $$RoutineStorageTableTableManager(
      _$AppDatabase db, $RoutineStorageTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RoutineStorageTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RoutineStorageTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$RoutineStorageTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> storageName = const Value.absent(),
          }) =>
              RoutineStorageCompanion(
            id: id,
            storageName: storageName,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> storageName = const Value.absent(),
          }) =>
              RoutineStorageCompanion.insert(
            id: id,
            storageName: storageName,
          ),
        ));
}

class $$RoutineStorageTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RoutineStorageTable,
    RoutineStorage,
    $$RoutineStorageTableFilterComposer,
    $$RoutineStorageTableOrderingComposer,
    $$RoutineStorageTableProcessedTableManager,
    $$RoutineStorageTableInsertCompanionBuilder,
    $$RoutineStorageTableUpdateCompanionBuilder> {
  $$RoutineStorageTableProcessedTableManager(super.$state);
}

class $$RoutineStorageTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RoutineStorageTable> {
  $$RoutineStorageTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get storageName => $state.composableBuilder(
      column: $state.table.storageName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter routineRefs(
      ComposableFilter Function($$RoutineTableFilterComposer f) f) {
    final $$RoutineTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.routine,
        getReferencedColumn: (t) => t.storageId,
        builder: (joinBuilder, parentComposers) => $$RoutineTableFilterComposer(
            ComposerState(
                $state.db, $state.db.routine, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$RoutineStorageTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RoutineStorageTable> {
  $$RoutineStorageTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get storageName => $state.composableBuilder(
      column: $state.table.storageName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RoutineTableInsertCompanionBuilder = RoutineCompanion Function({
  Value<int> id,
  Value<int?> storageId,
  Value<DateTime?> date,
  Value<bool> isFavor,
});
typedef $$RoutineTableUpdateCompanionBuilder = RoutineCompanion Function({
  Value<int> id,
  Value<int?> storageId,
  Value<DateTime?> date,
  Value<bool> isFavor,
});

class $$RoutineTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutineTable,
    Routine,
    $$RoutineTableFilterComposer,
    $$RoutineTableOrderingComposer,
    $$RoutineTableProcessedTableManager,
    $$RoutineTableInsertCompanionBuilder,
    $$RoutineTableUpdateCompanionBuilder> {
  $$RoutineTableTableManager(_$AppDatabase db, $RoutineTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RoutineTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RoutineTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$RoutineTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> storageId = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<bool> isFavor = const Value.absent(),
          }) =>
              RoutineCompanion(
            id: id,
            storageId: storageId,
            date: date,
            isFavor: isFavor,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> storageId = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<bool> isFavor = const Value.absent(),
          }) =>
              RoutineCompanion.insert(
            id: id,
            storageId: storageId,
            date: date,
            isFavor: isFavor,
          ),
        ));
}

class $$RoutineTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RoutineTable,
    Routine,
    $$RoutineTableFilterComposer,
    $$RoutineTableOrderingComposer,
    $$RoutineTableProcessedTableManager,
    $$RoutineTableInsertCompanionBuilder,
    $$RoutineTableUpdateCompanionBuilder> {
  $$RoutineTableProcessedTableManager(super.$state);
}

class $$RoutineTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RoutineTable> {
  $$RoutineTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  $$RoutineStorageTableFilterComposer get storageId {
    final $$RoutineStorageTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.storageId,
        referencedTable: $state.db.routineStorage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RoutineStorageTableFilterComposer(ComposerState($state.db,
                $state.db.routineStorage, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter workoutsRefs(
      ComposableFilter Function($$WorkoutsTableFilterComposer f) f) {
    final $$WorkoutsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.workouts,
        getReferencedColumn: (t) => t.routineId,
        builder: (joinBuilder, parentComposers) =>
            $$WorkoutsTableFilterComposer(ComposerState(
                $state.db, $state.db.workouts, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$RoutineTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RoutineTable> {
  $$RoutineTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  $$RoutineStorageTableOrderingComposer get storageId {
    final $$RoutineStorageTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.storageId,
            referencedTable: $state.db.routineStorage,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$RoutineStorageTableOrderingComposer(ComposerState($state.db,
                    $state.db.routineStorage, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$WorkoutsTableInsertCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  Value<int?> routineId,
  Value<String?> name,
  Value<double> targetRpe,
  Value<bool> showE1rm,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<int> id,
  Value<int?> routineId,
  Value<String?> name,
  Value<double> targetRpe,
  Value<bool> showE1rm,
});

class $$WorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workouts,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableProcessedTableManager,
    $$WorkoutsTableInsertCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder> {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkoutsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkoutsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkoutsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> routineId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<double> targetRpe = const Value.absent(),
            Value<bool> showE1rm = const Value.absent(),
          }) =>
              WorkoutsCompanion(
            id: id,
            routineId: routineId,
            name: name,
            targetRpe: targetRpe,
            showE1rm: showE1rm,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> routineId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<double> targetRpe = const Value.absent(),
            Value<bool> showE1rm = const Value.absent(),
          }) =>
              WorkoutsCompanion.insert(
            id: id,
            routineId: routineId,
            name: name,
            targetRpe: targetRpe,
            showE1rm: showE1rm,
          ),
        ));
}

class $$WorkoutsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workouts,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableProcessedTableManager,
    $$WorkoutsTableInsertCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder> {
  $$WorkoutsTableProcessedTableManager(super.$state);
}

class $$WorkoutsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get targetRpe => $state.composableBuilder(
      column: $state.table.targetRpe,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get showE1rm => $state.composableBuilder(
      column: $state.table.showE1rm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RoutineTableFilterComposer get routineId {
    final $$RoutineTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $state.db.routine,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$RoutineTableFilterComposer(
            ComposerState(
                $state.db, $state.db.routine, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter setsRefs(
      ComposableFilter Function($$SetsTableFilterComposer f) f) {
    final $$SetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.sets,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder, parentComposers) => $$SetsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.sets, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$WorkoutsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get targetRpe => $state.composableBuilder(
      column: $state.table.targetRpe,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get showE1rm => $state.composableBuilder(
      column: $state.table.showE1rm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RoutineTableOrderingComposer get routineId {
    final $$RoutineTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $state.db.routine,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RoutineTableOrderingComposer(ComposerState(
                $state.db, $state.db.routine, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$SetsTableInsertCompanionBuilder = SetsCompanion Function({
  Value<int> id,
  Value<int?> workoutId,
  required int setIndex,
  required double weight,
  required int reps,
  required double rpe,
  required double e1rm,
  required bool setComplete,
});
typedef $$SetsTableUpdateCompanionBuilder = SetsCompanion Function({
  Value<int> id,
  Value<int?> workoutId,
  Value<int> setIndex,
  Value<double> weight,
  Value<int> reps,
  Value<double> rpe,
  Value<double> e1rm,
  Value<bool> setComplete,
});

class $$SetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetsTable,
    Sets,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableProcessedTableManager,
    $$SetsTableInsertCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder> {
  $$SetsTableTableManager(_$AppDatabase db, $SetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SetsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$SetsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int> setIndex = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> rpe = const Value.absent(),
            Value<double> e1rm = const Value.absent(),
            Value<bool> setComplete = const Value.absent(),
          }) =>
              SetsCompanion(
            id: id,
            workoutId: workoutId,
            setIndex: setIndex,
            weight: weight,
            reps: reps,
            rpe: rpe,
            e1rm: e1rm,
            setComplete: setComplete,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            required int setIndex,
            required double weight,
            required int reps,
            required double rpe,
            required double e1rm,
            required bool setComplete,
          }) =>
              SetsCompanion.insert(
            id: id,
            workoutId: workoutId,
            setIndex: setIndex,
            weight: weight,
            reps: reps,
            rpe: rpe,
            e1rm: e1rm,
            setComplete: setComplete,
          ),
        ));
}

class $$SetsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $SetsTable,
    Sets,
    $$SetsTableFilterComposer,
    $$SetsTableOrderingComposer,
    $$SetsTableProcessedTableManager,
    $$SetsTableInsertCompanionBuilder,
    $$SetsTableUpdateCompanionBuilder> {
  $$SetsTableProcessedTableManager(super.$state);
}

class $$SetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SetsTable> {
  $$SetsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get setIndex => $state.composableBuilder(
      column: $state.table.setIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get reps => $state.composableBuilder(
      column: $state.table.reps,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get rpe => $state.composableBuilder(
      column: $state.table.rpe,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get e1rm => $state.composableBuilder(
      column: $state.table.e1rm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get setComplete => $state.composableBuilder(
      column: $state.table.setComplete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $state.db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$WorkoutsTableFilterComposer(ComposerState(
                $state.db, $state.db.workouts, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$SetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SetsTable> {
  $$SetsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get setIndex => $state.composableBuilder(
      column: $state.table.setIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get reps => $state.composableBuilder(
      column: $state.table.reps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get rpe => $state.composableBuilder(
      column: $state.table.rpe,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get e1rm => $state.composableBuilder(
      column: $state.table.e1rm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get setComplete => $state.composableBuilder(
      column: $state.table.setComplete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $state.db.workouts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$WorkoutsTableOrderingComposer(ComposerState(
                $state.db, $state.db.workouts, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$RoutineStorageTableTableManager get routineStorage =>
      $$RoutineStorageTableTableManager(_db, _db.routineStorage);
  $$RoutineTableTableManager get routine =>
      $$RoutineTableTableManager(_db, _db.routine);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$SetsTableTableManager get sets => $$SetsTableTableManager(_db, _db.sets);
}
