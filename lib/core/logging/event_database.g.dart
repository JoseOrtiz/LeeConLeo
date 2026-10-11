// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_database.dart';

// ignore_for_file: type=lint
class $ItemEventsTable extends ItemEvents with TableInfo<$ItemEventsTable, ItemEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<String> stepId = GeneratedColumn<String>(
    'step_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseMillisMeta = const VerificationMeta('responseMillis');
  @override
  late final GeneratedColumn<int> responseMillis = GeneratedColumn<int>(
    'response_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptMeta = const VerificationMeta('attempt');
  @override
  late final GeneratedColumn<int> attempt = GeneratedColumn<int>(
    'attempt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintUsedMeta = const VerificationMeta('hintUsed');
  @override
  late final GeneratedColumn<bool> hintUsed = GeneratedColumn<bool>(
    'hint_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("hint_used" IN (0, 1))'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    sessionId,
    stepId,
    activityId,
    itemId,
    target,
    answer,
    responseMillis,
    attempt,
    hintUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta, stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta, itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('target')) {
      context.handle(_targetMeta, target.isAcceptableOrUnknown(data['target']!, _targetMeta));
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta, answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('response_millis')) {
      context.handle(
        _responseMillisMeta,
        responseMillis.isAcceptableOrUnknown(data['response_millis']!, _responseMillisMeta),
      );
    } else if (isInserting) {
      context.missing(_responseMillisMeta);
    }
    if (data.containsKey('attempt')) {
      context.handle(_attemptMeta, attempt.isAcceptableOrUnknown(data['attempt']!, _attemptMeta));
    } else if (isInserting) {
      context.missing(_attemptMeta);
    }
    if (data.containsKey('hint_used')) {
      context.handle(
        _hintUsedMeta,
        hintUsed.isAcceptableOrUnknown(data['hint_used']!, _hintUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_hintUsedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemEventRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      stepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      responseMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}response_millis'],
      )!,
      attempt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt'],
      )!,
      hintUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hint_used'],
      )!,
    );
  }

  @override
  $ItemEventsTable createAlias(String alias) {
    return $ItemEventsTable(attachedDatabase, alias);
  }
}

class ItemEventRow extends DataClass implements Insertable<ItemEventRow> {
  final int id;
  final DateTime timestamp;
  final String sessionId;
  final String stepId;
  final String activityId;
  final String itemId;
  final String target;
  final String answer;
  final int responseMillis;
  final int attempt;
  final bool hintUsed;
  const ItemEventRow({
    required this.id,
    required this.timestamp,
    required this.sessionId,
    required this.stepId,
    required this.activityId,
    required this.itemId,
    required this.target,
    required this.answer,
    required this.responseMillis,
    required this.attempt,
    required this.hintUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['session_id'] = Variable<String>(sessionId);
    map['step_id'] = Variable<String>(stepId);
    map['activity_id'] = Variable<String>(activityId);
    map['item_id'] = Variable<String>(itemId);
    map['target'] = Variable<String>(target);
    map['answer'] = Variable<String>(answer);
    map['response_millis'] = Variable<int>(responseMillis);
    map['attempt'] = Variable<int>(attempt);
    map['hint_used'] = Variable<bool>(hintUsed);
    return map;
  }

  ItemEventsCompanion toCompanion(bool nullToAbsent) {
    return ItemEventsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      sessionId: Value(sessionId),
      stepId: Value(stepId),
      activityId: Value(activityId),
      itemId: Value(itemId),
      target: Value(target),
      answer: Value(answer),
      responseMillis: Value(responseMillis),
      attempt: Value(attempt),
      hintUsed: Value(hintUsed),
    );
  }

  factory ItemEventRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemEventRow(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      stepId: serializer.fromJson<String>(json['stepId']),
      activityId: serializer.fromJson<String>(json['activityId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      target: serializer.fromJson<String>(json['target']),
      answer: serializer.fromJson<String>(json['answer']),
      responseMillis: serializer.fromJson<int>(json['responseMillis']),
      attempt: serializer.fromJson<int>(json['attempt']),
      hintUsed: serializer.fromJson<bool>(json['hintUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'sessionId': serializer.toJson<String>(sessionId),
      'stepId': serializer.toJson<String>(stepId),
      'activityId': serializer.toJson<String>(activityId),
      'itemId': serializer.toJson<String>(itemId),
      'target': serializer.toJson<String>(target),
      'answer': serializer.toJson<String>(answer),
      'responseMillis': serializer.toJson<int>(responseMillis),
      'attempt': serializer.toJson<int>(attempt),
      'hintUsed': serializer.toJson<bool>(hintUsed),
    };
  }

  ItemEventRow copyWith({
    int? id,
    DateTime? timestamp,
    String? sessionId,
    String? stepId,
    String? activityId,
    String? itemId,
    String? target,
    String? answer,
    int? responseMillis,
    int? attempt,
    bool? hintUsed,
  }) => ItemEventRow(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    sessionId: sessionId ?? this.sessionId,
    stepId: stepId ?? this.stepId,
    activityId: activityId ?? this.activityId,
    itemId: itemId ?? this.itemId,
    target: target ?? this.target,
    answer: answer ?? this.answer,
    responseMillis: responseMillis ?? this.responseMillis,
    attempt: attempt ?? this.attempt,
    hintUsed: hintUsed ?? this.hintUsed,
  );
  ItemEventRow copyWithCompanion(ItemEventsCompanion data) {
    return ItemEventRow(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      activityId: data.activityId.present ? data.activityId.value : this.activityId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      target: data.target.present ? data.target.value : this.target,
      answer: data.answer.present ? data.answer.value : this.answer,
      responseMillis: data.responseMillis.present ? data.responseMillis.value : this.responseMillis,
      attempt: data.attempt.present ? data.attempt.value : this.attempt,
      hintUsed: data.hintUsed.present ? data.hintUsed.value : this.hintUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemEventRow(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('sessionId: $sessionId, ')
          ..write('stepId: $stepId, ')
          ..write('activityId: $activityId, ')
          ..write('itemId: $itemId, ')
          ..write('target: $target, ')
          ..write('answer: $answer, ')
          ..write('responseMillis: $responseMillis, ')
          ..write('attempt: $attempt, ')
          ..write('hintUsed: $hintUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    sessionId,
    stepId,
    activityId,
    itemId,
    target,
    answer,
    responseMillis,
    attempt,
    hintUsed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemEventRow &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.sessionId == this.sessionId &&
          other.stepId == this.stepId &&
          other.activityId == this.activityId &&
          other.itemId == this.itemId &&
          other.target == this.target &&
          other.answer == this.answer &&
          other.responseMillis == this.responseMillis &&
          other.attempt == this.attempt &&
          other.hintUsed == this.hintUsed);
}

class ItemEventsCompanion extends UpdateCompanion<ItemEventRow> {
  final Value<int> id;
  final Value<DateTime> timestamp;
  final Value<String> sessionId;
  final Value<String> stepId;
  final Value<String> activityId;
  final Value<String> itemId;
  final Value<String> target;
  final Value<String> answer;
  final Value<int> responseMillis;
  final Value<int> attempt;
  final Value<bool> hintUsed;
  const ItemEventsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.target = const Value.absent(),
    this.answer = const Value.absent(),
    this.responseMillis = const Value.absent(),
    this.attempt = const Value.absent(),
    this.hintUsed = const Value.absent(),
  });
  ItemEventsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime timestamp,
    required String sessionId,
    required String stepId,
    required String activityId,
    required String itemId,
    required String target,
    required String answer,
    required int responseMillis,
    required int attempt,
    required bool hintUsed,
  }) : timestamp = Value(timestamp),
       sessionId = Value(sessionId),
       stepId = Value(stepId),
       activityId = Value(activityId),
       itemId = Value(itemId),
       target = Value(target),
       answer = Value(answer),
       responseMillis = Value(responseMillis),
       attempt = Value(attempt),
       hintUsed = Value(hintUsed);
  static Insertable<ItemEventRow> custom({
    Expression<int>? id,
    Expression<DateTime>? timestamp,
    Expression<String>? sessionId,
    Expression<String>? stepId,
    Expression<String>? activityId,
    Expression<String>? itemId,
    Expression<String>? target,
    Expression<String>? answer,
    Expression<int>? responseMillis,
    Expression<int>? attempt,
    Expression<bool>? hintUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (sessionId != null) 'session_id': sessionId,
      if (stepId != null) 'step_id': stepId,
      if (activityId != null) 'activity_id': activityId,
      if (itemId != null) 'item_id': itemId,
      if (target != null) 'target': target,
      if (answer != null) 'answer': answer,
      if (responseMillis != null) 'response_millis': responseMillis,
      if (attempt != null) 'attempt': attempt,
      if (hintUsed != null) 'hint_used': hintUsed,
    });
  }

  ItemEventsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? timestamp,
    Value<String>? sessionId,
    Value<String>? stepId,
    Value<String>? activityId,
    Value<String>? itemId,
    Value<String>? target,
    Value<String>? answer,
    Value<int>? responseMillis,
    Value<int>? attempt,
    Value<bool>? hintUsed,
  }) {
    return ItemEventsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      sessionId: sessionId ?? this.sessionId,
      stepId: stepId ?? this.stepId,
      activityId: activityId ?? this.activityId,
      itemId: itemId ?? this.itemId,
      target: target ?? this.target,
      answer: answer ?? this.answer,
      responseMillis: responseMillis ?? this.responseMillis,
      attempt: attempt ?? this.attempt,
      hintUsed: hintUsed ?? this.hintUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (responseMillis.present) {
      map['response_millis'] = Variable<int>(responseMillis.value);
    }
    if (attempt.present) {
      map['attempt'] = Variable<int>(attempt.value);
    }
    if (hintUsed.present) {
      map['hint_used'] = Variable<bool>(hintUsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemEventsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('sessionId: $sessionId, ')
          ..write('stepId: $stepId, ')
          ..write('activityId: $activityId, ')
          ..write('itemId: $itemId, ')
          ..write('target: $target, ')
          ..write('answer: $answer, ')
          ..write('responseMillis: $responseMillis, ')
          ..write('attempt: $attempt, ')
          ..write('hintUsed: $hintUsed')
          ..write(')'))
        .toString();
  }
}

abstract class _$EventDatabase extends GeneratedDatabase {
  _$EventDatabase(QueryExecutor e) : super(e);
  $EventDatabaseManager get managers => $EventDatabaseManager(this);
  late final $ItemEventsTable itemEvents = $ItemEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [itemEvents];
}

typedef $$ItemEventsTableCreateCompanionBuilder =
    ItemEventsCompanion Function({
      Value<int> id,
      required DateTime timestamp,
      required String sessionId,
      required String stepId,
      required String activityId,
      required String itemId,
      required String target,
      required String answer,
      required int responseMillis,
      required int attempt,
      required bool hintUsed,
    });
typedef $$ItemEventsTableUpdateCompanionBuilder =
    ItemEventsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      Value<String> sessionId,
      Value<String> stepId,
      Value<String> activityId,
      Value<String> itemId,
      Value<String> target,
      Value<String> answer,
      Value<int> responseMillis,
      Value<int> attempt,
      Value<bool> hintUsed,
    });

class $$ItemEventsTableFilterComposer extends Composer<_$EventDatabase, $ItemEventsTable> {
  $$ItemEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get responseMillis =>
      $composableBuilder(column: $table.responseMillis, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempt =>
      $composableBuilder(column: $table.attempt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hintUsed =>
      $composableBuilder(column: $table.hintUsed, builder: (column) => ColumnFilters(column));
}

class $$ItemEventsTableOrderingComposer extends Composer<_$EventDatabase, $ItemEventsTable> {
  $$ItemEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get responseMillis => $composableBuilder(
    column: $table.responseMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempt =>
      $composableBuilder(column: $table.attempt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hintUsed =>
      $composableBuilder(column: $table.hintUsed, builder: (column) => ColumnOrderings(column));
}

class $$ItemEventsTableAnnotationComposer extends Composer<_$EventDatabase, $ItemEventsTable> {
  $$ItemEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<int> get responseMillis =>
      $composableBuilder(column: $table.responseMillis, builder: (column) => column);

  GeneratedColumn<int> get attempt =>
      $composableBuilder(column: $table.attempt, builder: (column) => column);

  GeneratedColumn<bool> get hintUsed =>
      $composableBuilder(column: $table.hintUsed, builder: (column) => column);
}

class $$ItemEventsTableTableManager
    extends
        RootTableManager<
          _$EventDatabase,
          $ItemEventsTable,
          ItemEventRow,
          $$ItemEventsTableFilterComposer,
          $$ItemEventsTableOrderingComposer,
          $$ItemEventsTableAnnotationComposer,
          $$ItemEventsTableCreateCompanionBuilder,
          $$ItemEventsTableUpdateCompanionBuilder,
          (ItemEventRow, BaseReferences<_$EventDatabase, $ItemEventsTable, ItemEventRow>),
          ItemEventRow,
          PrefetchHooks Function()
        > {
  $$ItemEventsTableTableManager(_$EventDatabase db, $ItemEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ItemEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ItemEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> stepId = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> target = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<int> responseMillis = const Value.absent(),
                Value<int> attempt = const Value.absent(),
                Value<bool> hintUsed = const Value.absent(),
              }) => ItemEventsCompanion(
                id: id,
                timestamp: timestamp,
                sessionId: sessionId,
                stepId: stepId,
                activityId: activityId,
                itemId: itemId,
                target: target,
                answer: answer,
                responseMillis: responseMillis,
                attempt: attempt,
                hintUsed: hintUsed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime timestamp,
                required String sessionId,
                required String stepId,
                required String activityId,
                required String itemId,
                required String target,
                required String answer,
                required int responseMillis,
                required int attempt,
                required bool hintUsed,
              }) => ItemEventsCompanion.insert(
                id: id,
                timestamp: timestamp,
                sessionId: sessionId,
                stepId: stepId,
                activityId: activityId,
                itemId: itemId,
                target: target,
                answer: answer,
                responseMillis: responseMillis,
                attempt: attempt,
                hintUsed: hintUsed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemEventsTable, ItemEventRow>(table),
                  BaseReferences<_$EventDatabase, $ItemEventsTable, ItemEventRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$EventDatabase,
      $ItemEventsTable,
      ItemEventRow,
      $$ItemEventsTableFilterComposer,
      $$ItemEventsTableOrderingComposer,
      $$ItemEventsTableAnnotationComposer,
      $$ItemEventsTableCreateCompanionBuilder,
      $$ItemEventsTableUpdateCompanionBuilder,
      (ItemEventRow, BaseReferences<_$EventDatabase, $ItemEventsTable, ItemEventRow>),
      ItemEventRow,
      PrefetchHooks Function()
    >;

class $EventDatabaseManager {
  final _$EventDatabase _db;
  $EventDatabaseManager(this._db);
  $$ItemEventsTableTableManager get itemEvents =>
      $$ItemEventsTableTableManager(_db, _db.itemEvents);
}
