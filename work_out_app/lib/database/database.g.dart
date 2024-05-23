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
      'routine_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  List<GeneratedColumn> get $columns => [id, routineName, date, isFavor];
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
      routineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_name']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      isFavor: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favor'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final int id;
  final String? routineName;
  final DateTime? date;
  final bool isFavor;
  const Routine(
      {required this.id, this.routineName, this.date, required this.isFavor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || routineName != null) {
      map['routine_name'] = Variable<String>(routineName);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    map['is_favor'] = Variable<bool>(isFavor);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      routineName: routineName == null && nullToAbsent
          ? const Value.absent()
          : Value(routineName),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      isFavor: Value(isFavor),
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<int>(json['id']),
      routineName: serializer.fromJson<String?>(json['routineName']),
      date: serializer.fromJson<DateTime?>(json['date']),
      isFavor: serializer.fromJson<bool>(json['isFavor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineName': serializer.toJson<String?>(routineName),
      'date': serializer.toJson<DateTime?>(date),
      'isFavor': serializer.toJson<bool>(isFavor),
    };
  }

  Routine copyWith(
          {int? id,
          Value<String?> routineName = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          bool? isFavor}) =>
      Routine(
        id: id ?? this.id,
        routineName: routineName.present ? routineName.value : this.routineName,
        date: date.present ? date.value : this.date,
        isFavor: isFavor ?? this.isFavor,
      );
  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineName, date, isFavor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.routineName == this.routineName &&
          other.date == this.date &&
          other.isFavor == this.isFavor);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<int> id;
  final Value<String?> routineName;
  final Value<DateTime?> date;
  final Value<bool> isFavor;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.routineName = const Value.absent(),
    this.date = const Value.absent(),
    this.isFavor = const Value.absent(),
  });
  RoutinesCompanion.insert({
    this.id = const Value.absent(),
    this.routineName = const Value.absent(),
    this.date = const Value.absent(),
    this.isFavor = const Value.absent(),
  });
  static Insertable<Routine> custom({
    Expression<int>? id,
    Expression<String>? routineName,
    Expression<DateTime>? date,
    Expression<bool>? isFavor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineName != null) 'routine_name': routineName,
      if (date != null) 'date': date,
      if (isFavor != null) 'is_favor': isFavor,
    });
  }

  RoutinesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? routineName,
      Value<DateTime?>? date,
      Value<bool>? isFavor}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      routineName: routineName ?? this.routineName,
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
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
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
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('routineName: $routineName, ')
          ..write('date: $date, ')
          ..write('isFavor: $isFavor')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES routines (id)'));
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
  VerificationContext validateIntegrity(Insertable<Workout> instance,
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
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
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

class Workout extends DataClass implements Insertable<Workout> {
  final int id;
  final int? routineId;
  final String? name;
  final double targetRpe;
  final bool showE1rm;
  const Workout(
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

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
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

  Workout copyWith(
          {int? id,
          Value<int?> routineId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          double? targetRpe,
          bool? showE1rm}) =>
      Workout(
        id: id ?? this.id,
        routineId: routineId.present ? routineId.value : this.routineId,
        name: name.present ? name.value : this.name,
        targetRpe: targetRpe ?? this.targetRpe,
        showE1rm: showE1rm ?? this.showE1rm,
      );
  @override
  String toString() {
    return (StringBuffer('Workout(')
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
      (other is Workout &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.targetRpe == this.targetRpe &&
          other.showE1rm == this.showE1rm);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
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
  static Insertable<Workout> custom({
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

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workouts (id)'));
  static const VerificationMeta _setIndexMeta =
      const VerificationMeta('setIndex');
  @override
  late final GeneratedColumn<int> setIndex = GeneratedColumn<int>(
      'set_index', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
      'rpe', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _e1rmMeta = const VerificationMeta('e1rm');
  @override
  late final GeneratedColumn<double> e1rm = GeneratedColumn<double>(
      'e1rm', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _setCompleteMeta =
      const VerificationMeta('setComplete');
  @override
  late final GeneratedColumn<bool> setComplete = GeneratedColumn<bool>(
      'set_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("set_complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutId, setIndex, weight, reps, rpe, e1rm, setComplete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSet> instance,
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
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    }
    if (data.containsKey('e1rm')) {
      context.handle(
          _e1rmMeta, e1rm.isAcceptableOrUnknown(data['e1rm']!, _e1rmMeta));
    }
    if (data.containsKey('set_complete')) {
      context.handle(
          _setCompleteMeta,
          setComplete.isAcceptableOrUnknown(
              data['set_complete']!, _setCompleteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id']),
      setIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_index']),
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
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final int id;
  final int? workoutId;
  final int? setIndex;
  final double weight;
  final int reps;
  final double rpe;
  final double e1rm;
  final bool setComplete;
  const WorkoutSet(
      {required this.id,
      this.workoutId,
      this.setIndex,
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
    if (!nullToAbsent || setIndex != null) {
      map['set_index'] = Variable<int>(setIndex);
    }
    map['weight'] = Variable<double>(weight);
    map['reps'] = Variable<int>(reps);
    map['rpe'] = Variable<double>(rpe);
    map['e1rm'] = Variable<double>(e1rm);
    map['set_complete'] = Variable<bool>(setComplete);
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      setIndex: setIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(setIndex),
      weight: Value(weight),
      reps: Value(reps),
      rpe: Value(rpe),
      e1rm: Value(e1rm),
      setComplete: Value(setComplete),
    );
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<int?>(json['workoutId']),
      setIndex: serializer.fromJson<int?>(json['setIndex']),
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
      'setIndex': serializer.toJson<int?>(setIndex),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<int>(reps),
      'rpe': serializer.toJson<double>(rpe),
      'e1rm': serializer.toJson<double>(e1rm),
      'setComplete': serializer.toJson<bool>(setComplete),
    };
  }

  WorkoutSet copyWith(
          {int? id,
          Value<int?> workoutId = const Value.absent(),
          Value<int?> setIndex = const Value.absent(),
          double? weight,
          int? reps,
          double? rpe,
          double? e1rm,
          bool? setComplete}) =>
      WorkoutSet(
        id: id ?? this.id,
        workoutId: workoutId.present ? workoutId.value : this.workoutId,
        setIndex: setIndex.present ? setIndex.value : this.setIndex,
        weight: weight ?? this.weight,
        reps: reps ?? this.reps,
        rpe: rpe ?? this.rpe,
        e1rm: e1rm ?? this.e1rm,
        setComplete: setComplete ?? this.setComplete,
      );
  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
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
      (other is WorkoutSet &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.setIndex == this.setIndex &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.rpe == this.rpe &&
          other.e1rm == this.e1rm &&
          other.setComplete == this.setComplete);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<int> id;
  final Value<int?> workoutId;
  final Value<int?> setIndex;
  final Value<double> weight;
  final Value<int> reps;
  final Value<double> rpe;
  final Value<double> e1rm;
  final Value<bool> setComplete;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.e1rm = const Value.absent(),
    this.setComplete = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.e1rm = const Value.absent(),
    this.setComplete = const Value.absent(),
  });
  static Insertable<WorkoutSet> custom({
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

  WorkoutSetsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? workoutId,
      Value<int?>? setIndex,
      Value<double>? weight,
      Value<int>? reps,
      Value<double>? rpe,
      Value<double>? e1rm,
      Value<bool>? setComplete}) {
    return WorkoutSetsCompanion(
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
    return (StringBuffer('WorkoutSetsCompanion(')
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
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [routines, workouts, workoutSets];
}

typedef $$RoutinesTableInsertCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<String?> routineName,
  Value<DateTime?> date,
  Value<bool> isFavor,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<int> id,
  Value<String?> routineName,
  Value<DateTime?> date,
  Value<bool> isFavor,
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
            Value<String?> routineName = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<bool> isFavor = const Value.absent(),
          }) =>
              RoutinesCompanion(
            id: id,
            routineName: routineName,
            date: date,
            isFavor: isFavor,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> routineName = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<bool> isFavor = const Value.absent(),
          }) =>
              RoutinesCompanion.insert(
            id: id,
            routineName: routineName,
            date: date,
            isFavor: isFavor,
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
    Workout,
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
    Workout,
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

  $$RoutinesTableFilterComposer get routineId {
    final $$RoutinesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $state.db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RoutinesTableFilterComposer(ComposerState(
                $state.db, $state.db.routines, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter workoutSetsRefs(
      ComposableFilter Function($$WorkoutSetsTableFilterComposer f) f) {
    final $$WorkoutSetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.workoutSets,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder, parentComposers) =>
            $$WorkoutSetsTableFilterComposer(ComposerState($state.db,
                $state.db.workoutSets, joinBuilder, parentComposers)));
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

  $$RoutinesTableOrderingComposer get routineId {
    final $$RoutinesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.routineId,
        referencedTable: $state.db.routines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RoutinesTableOrderingComposer(ComposerState(
                $state.db, $state.db.routines, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$WorkoutSetsTableInsertCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  Value<int?> workoutId,
  Value<int?> setIndex,
  Value<double> weight,
  Value<int> reps,
  Value<double> rpe,
  Value<double> e1rm,
  Value<bool> setComplete,
});
typedef $$WorkoutSetsTableUpdateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  Value<int?> workoutId,
  Value<int?> setIndex,
  Value<double> weight,
  Value<int> reps,
  Value<double> rpe,
  Value<double> e1rm,
  Value<bool> setComplete,
});

class $$WorkoutSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableProcessedTableManager,
    $$WorkoutSetsTableInsertCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder> {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkoutSetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkoutSetsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkoutSetsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int?> setIndex = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> rpe = const Value.absent(),
            Value<double> e1rm = const Value.absent(),
            Value<bool> setComplete = const Value.absent(),
          }) =>
              WorkoutSetsCompanion(
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
            Value<int?> setIndex = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> rpe = const Value.absent(),
            Value<double> e1rm = const Value.absent(),
            Value<bool> setComplete = const Value.absent(),
          }) =>
              WorkoutSetsCompanion.insert(
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

class $$WorkoutSetsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableProcessedTableManager,
    $$WorkoutSetsTableInsertCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder> {
  $$WorkoutSetsTableProcessedTableManager(super.$state);
}

class $$WorkoutSetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer(super.$state);
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

class $$WorkoutSetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer(super.$state);
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
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
}
