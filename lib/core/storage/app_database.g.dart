// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nickname, avatar, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta, avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;
  final String nickname;
  final String avatar;
  final DateTime createdAt;
  const ProfileRow({
    required this.id,
    required this.nickname,
    required this.avatar,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nickname'] = Variable<String>(nickname);
    map['avatar'] = Variable<String>(avatar);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      nickname: Value(nickname),
      avatar: Value(avatar),
      createdAt: Value(createdAt),
    );
  }

  factory ProfileRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      avatar: serializer.fromJson<String>(json['avatar']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nickname': serializer.toJson<String>(nickname),
      'avatar': serializer.toJson<String>(avatar),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProfileRow copyWith({int? id, String? nickname, String? avatar, DateTime? createdAt}) =>
      ProfileRow(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
      );
  ProfileRow copyWithCompanion(ProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('avatar: $avatar, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nickname, avatar, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.avatar == this.avatar &&
          other.createdAt == this.createdAt);
}

class ProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<String> nickname;
  final Value<String> avatar;
  final Value<DateTime> createdAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.avatar = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String nickname,
    required String avatar,
    required DateTime createdAt,
  }) : nickname = Value(nickname),
       avatar = Value(avatar),
       createdAt = Value(createdAt);
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<String>? nickname,
    Expression<String>? avatar,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? nickname,
    Value<String>? avatar,
    Value<DateTime>? createdAt,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('avatar: $avatar, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CompletedStepsTable extends CompletedSteps
    with TableInfo<$CompletedStepsTable, CompletedStepRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletedStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _completedAtMeta = const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [profileId, stepId, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completed_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletedStepRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta, stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(data['completed_at']!, _completedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, stepId};
  @override
  CompletedStepRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedStepRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      stepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $CompletedStepsTable createAlias(String alias) {
    return $CompletedStepsTable(attachedDatabase, alias);
  }
}

class CompletedStepRow extends DataClass implements Insertable<CompletedStepRow> {
  final int profileId;
  final String stepId;
  final DateTime completedAt;
  const CompletedStepRow({
    required this.profileId,
    required this.stepId,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['step_id'] = Variable<String>(stepId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  CompletedStepsCompanion toCompanion(bool nullToAbsent) {
    return CompletedStepsCompanion(
      profileId: Value(profileId),
      stepId: Value(stepId),
      completedAt: Value(completedAt),
    );
  }

  factory CompletedStepRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletedStepRow(
      profileId: serializer.fromJson<int>(json['profileId']),
      stepId: serializer.fromJson<String>(json['stepId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'stepId': serializer.toJson<String>(stepId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  CompletedStepRow copyWith({int? profileId, String? stepId, DateTime? completedAt}) =>
      CompletedStepRow(
        profileId: profileId ?? this.profileId,
        stepId: stepId ?? this.stepId,
        completedAt: completedAt ?? this.completedAt,
      );
  CompletedStepRow copyWithCompanion(CompletedStepsCompanion data) {
    return CompletedStepRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      completedAt: data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletedStepRow(')
          ..write('profileId: $profileId, ')
          ..write('stepId: $stepId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, stepId, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedStepRow &&
          other.profileId == this.profileId &&
          other.stepId == this.stepId &&
          other.completedAt == this.completedAt);
}

class CompletedStepsCompanion extends UpdateCompanion<CompletedStepRow> {
  final Value<int> profileId;
  final Value<String> stepId;
  final Value<DateTime> completedAt;
  final Value<int> rowid;
  const CompletedStepsCompanion({
    this.profileId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletedStepsCompanion.insert({
    required int profileId,
    required String stepId,
    required DateTime completedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       stepId = Value(stepId),
       completedAt = Value(completedAt);
  static Insertable<CompletedStepRow> custom({
    Expression<int>? profileId,
    Expression<String>? stepId,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (stepId != null) 'step_id': stepId,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletedStepsCompanion copyWith({
    Value<int>? profileId,
    Value<String>? stepId,
    Value<DateTime>? completedAt,
    Value<int>? rowid,
  }) {
    return CompletedStepsCompanion(
      profileId: profileId ?? this.profileId,
      stepId: stepId ?? this.stepId,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletedStepsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('stepId: $stepId, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayedGamesTable extends PlayedGames with TableInfo<$PlayedGamesTable, PlayedGameRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayedGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _playedAtMeta = const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [profileId, stepId, activityId, playedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'played_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayedGameRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
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
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, stepId, activityId};
  @override
  PlayedGameRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayedGameRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      stepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $PlayedGamesTable createAlias(String alias) {
    return $PlayedGamesTable(attachedDatabase, alias);
  }
}

class PlayedGameRow extends DataClass implements Insertable<PlayedGameRow> {
  final int profileId;
  final String stepId;
  final String activityId;
  final DateTime playedAt;
  const PlayedGameRow({
    required this.profileId,
    required this.stepId,
    required this.activityId,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['step_id'] = Variable<String>(stepId);
    map['activity_id'] = Variable<String>(activityId);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  PlayedGamesCompanion toCompanion(bool nullToAbsent) {
    return PlayedGamesCompanion(
      profileId: Value(profileId),
      stepId: Value(stepId),
      activityId: Value(activityId),
      playedAt: Value(playedAt),
    );
  }

  factory PlayedGameRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayedGameRow(
      profileId: serializer.fromJson<int>(json['profileId']),
      stepId: serializer.fromJson<String>(json['stepId']),
      activityId: serializer.fromJson<String>(json['activityId']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'stepId': serializer.toJson<String>(stepId),
      'activityId': serializer.toJson<String>(activityId),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  PlayedGameRow copyWith({
    int? profileId,
    String? stepId,
    String? activityId,
    DateTime? playedAt,
  }) => PlayedGameRow(
    profileId: profileId ?? this.profileId,
    stepId: stepId ?? this.stepId,
    activityId: activityId ?? this.activityId,
    playedAt: playedAt ?? this.playedAt,
  );
  PlayedGameRow copyWithCompanion(PlayedGamesCompanion data) {
    return PlayedGameRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      activityId: data.activityId.present ? data.activityId.value : this.activityId,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayedGameRow(')
          ..write('profileId: $profileId, ')
          ..write('stepId: $stepId, ')
          ..write('activityId: $activityId, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, stepId, activityId, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayedGameRow &&
          other.profileId == this.profileId &&
          other.stepId == this.stepId &&
          other.activityId == this.activityId &&
          other.playedAt == this.playedAt);
}

class PlayedGamesCompanion extends UpdateCompanion<PlayedGameRow> {
  final Value<int> profileId;
  final Value<String> stepId;
  final Value<String> activityId;
  final Value<DateTime> playedAt;
  final Value<int> rowid;
  const PlayedGamesCompanion({
    this.profileId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayedGamesCompanion.insert({
    required int profileId,
    required String stepId,
    required String activityId,
    required DateTime playedAt,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       stepId = Value(stepId),
       activityId = Value(activityId),
       playedAt = Value(playedAt);
  static Insertable<PlayedGameRow> custom({
    Expression<int>? profileId,
    Expression<String>? stepId,
    Expression<String>? activityId,
    Expression<DateTime>? playedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (stepId != null) 'step_id': stepId,
      if (activityId != null) 'activity_id': activityId,
      if (playedAt != null) 'played_at': playedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayedGamesCompanion copyWith({
    Value<int>? profileId,
    Value<String>? stepId,
    Value<String>? activityId,
    Value<DateTime>? playedAt,
    Value<int>? rowid,
  }) {
    return PlayedGamesCompanion(
      profileId: profileId ?? this.profileId,
      stepId: stepId ?? this.stepId,
      activityId: activityId ?? this.activityId,
      playedAt: playedAt ?? this.playedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayedGamesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('stepId: $stepId, ')
          ..write('activityId: $activityId, ')
          ..write('playedAt: $playedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _profileIdMeta = const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    profileId,
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
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
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
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
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
  final int profileId;
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
    required this.profileId,
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
    map['profile_id'] = Variable<int>(profileId);
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
      profileId: Value(profileId),
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
      profileId: serializer.fromJson<int>(json['profileId']),
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
      'profileId': serializer.toJson<int>(profileId),
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
    int? profileId,
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
    profileId: profileId ?? this.profileId,
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
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
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
          ..write('profileId: $profileId, ')
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
    profileId,
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
          other.profileId == this.profileId &&
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
  final Value<int> profileId;
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
    this.profileId = const Value.absent(),
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
    this.profileId = const Value.absent(),
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
    Expression<int>? profileId,
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
      if (profileId != null) 'profile_id': profileId,
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
    Value<int>? profileId,
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
      profileId: profileId ?? this.profileId,
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
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
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
          ..write('profileId: $profileId, ')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $CompletedStepsTable completedSteps = $CompletedStepsTable(this);
  late final $PlayedGamesTable playedGames = $PlayedGamesTable(this);
  late final $ItemEventsTable itemEvents = $ItemEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    completedSteps,
    playedGames,
    itemEvents,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required String nickname,
      required String avatar,
      required DateTime createdAt,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> nickname,
      Value<String> avatar,
      Value<DateTime> createdAt,
    });

class $$ProfilesTableFilterComposer extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ProfilesTableOrderingComposer extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          ProfileRow,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (ProfileRow, BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<String> avatar = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                nickname: nickname,
                avatar: avatar,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nickname,
                required String avatar,
                required DateTime createdAt,
              }) => ProfilesCompanion.insert(
                id: id,
                nickname: nickname,
                avatar: avatar,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, ProfileRow>(table),
                  BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      ProfileRow,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (ProfileRow, BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow>),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$CompletedStepsTableCreateCompanionBuilder =
    CompletedStepsCompanion Function({
      required int profileId,
      required String stepId,
      required DateTime completedAt,
      Value<int> rowid,
    });
typedef $$CompletedStepsTableUpdateCompanionBuilder =
    CompletedStepsCompanion Function({
      Value<int> profileId,
      Value<String> stepId,
      Value<DateTime> completedAt,
      Value<int> rowid,
    });

class $$CompletedStepsTableFilterComposer extends Composer<_$AppDatabase, $CompletedStepsTable> {
  $$CompletedStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt =>
      $composableBuilder(column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$CompletedStepsTableOrderingComposer extends Composer<_$AppDatabase, $CompletedStepsTable> {
  $$CompletedStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt =>
      $composableBuilder(column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$CompletedStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletedStepsTable> {
  $$CompletedStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt =>
      $composableBuilder(column: $table.completedAt, builder: (column) => column);
}

class $$CompletedStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompletedStepsTable,
          CompletedStepRow,
          $$CompletedStepsTableFilterComposer,
          $$CompletedStepsTableOrderingComposer,
          $$CompletedStepsTableAnnotationComposer,
          $$CompletedStepsTableCreateCompanionBuilder,
          $$CompletedStepsTableUpdateCompanionBuilder,
          (CompletedStepRow, BaseReferences<_$AppDatabase, $CompletedStepsTable, CompletedStepRow>),
          CompletedStepRow,
          PrefetchHooks Function()
        > {
  $$CompletedStepsTableTableManager(_$AppDatabase db, $CompletedStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletedStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletedStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletedStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<String> stepId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletedStepsCompanion(
                profileId: profileId,
                stepId: stepId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required String stepId,
                required DateTime completedAt,
                Value<int> rowid = const Value.absent(),
              }) => CompletedStepsCompanion.insert(
                profileId: profileId,
                stepId: stepId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CompletedStepsTable, CompletedStepRow>(table),
                  BaseReferences<_$AppDatabase, $CompletedStepsTable, CompletedStepRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompletedStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompletedStepsTable,
      CompletedStepRow,
      $$CompletedStepsTableFilterComposer,
      $$CompletedStepsTableOrderingComposer,
      $$CompletedStepsTableAnnotationComposer,
      $$CompletedStepsTableCreateCompanionBuilder,
      $$CompletedStepsTableUpdateCompanionBuilder,
      (CompletedStepRow, BaseReferences<_$AppDatabase, $CompletedStepsTable, CompletedStepRow>),
      CompletedStepRow,
      PrefetchHooks Function()
    >;
typedef $$PlayedGamesTableCreateCompanionBuilder =
    PlayedGamesCompanion Function({
      required int profileId,
      required String stepId,
      required String activityId,
      required DateTime playedAt,
      Value<int> rowid,
    });
typedef $$PlayedGamesTableUpdateCompanionBuilder =
    PlayedGamesCompanion Function({
      Value<int> profileId,
      Value<String> stepId,
      Value<String> activityId,
      Value<DateTime> playedAt,
      Value<int> rowid,
    });

class $$PlayedGamesTableFilterComposer extends Composer<_$AppDatabase, $PlayedGamesTable> {
  $$PlayedGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => ColumnFilters(column));
}

class $$PlayedGamesTableOrderingComposer extends Composer<_$AppDatabase, $PlayedGamesTable> {
  $$PlayedGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => ColumnOrderings(column));
}

class $$PlayedGamesTableAnnotationComposer extends Composer<_$AppDatabase, $PlayedGamesTable> {
  $$PlayedGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<String> get activityId =>
      $composableBuilder(column: $table.activityId, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$PlayedGamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayedGamesTable,
          PlayedGameRow,
          $$PlayedGamesTableFilterComposer,
          $$PlayedGamesTableOrderingComposer,
          $$PlayedGamesTableAnnotationComposer,
          $$PlayedGamesTableCreateCompanionBuilder,
          $$PlayedGamesTableUpdateCompanionBuilder,
          (PlayedGameRow, BaseReferences<_$AppDatabase, $PlayedGamesTable, PlayedGameRow>),
          PlayedGameRow,
          PrefetchHooks Function()
        > {
  $$PlayedGamesTableTableManager(_$AppDatabase db, $PlayedGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PlayedGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PlayedGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayedGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<String> stepId = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayedGamesCompanion(
                profileId: profileId,
                stepId: stepId,
                activityId: activityId,
                playedAt: playedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required String stepId,
                required String activityId,
                required DateTime playedAt,
                Value<int> rowid = const Value.absent(),
              }) => PlayedGamesCompanion.insert(
                profileId: profileId,
                stepId: stepId,
                activityId: activityId,
                playedAt: playedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlayedGamesTable, PlayedGameRow>(table),
                  BaseReferences<_$AppDatabase, $PlayedGamesTable, PlayedGameRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayedGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayedGamesTable,
      PlayedGameRow,
      $$PlayedGamesTableFilterComposer,
      $$PlayedGamesTableOrderingComposer,
      $$PlayedGamesTableAnnotationComposer,
      $$PlayedGamesTableCreateCompanionBuilder,
      $$PlayedGamesTableUpdateCompanionBuilder,
      (PlayedGameRow, BaseReferences<_$AppDatabase, $PlayedGamesTable, PlayedGameRow>),
      PlayedGameRow,
      PrefetchHooks Function()
    >;
typedef $$ItemEventsTableCreateCompanionBuilder =
    ItemEventsCompanion Function({
      Value<int> id,
      Value<int> profileId,
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
      Value<int> profileId,
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

class $$ItemEventsTableFilterComposer extends Composer<_$AppDatabase, $ItemEventsTable> {
  $$ItemEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnFilters(column));

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

class $$ItemEventsTableOrderingComposer extends Composer<_$AppDatabase, $ItemEventsTable> {
  $$ItemEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => ColumnOrderings(column));

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

class $$ItemEventsTableAnnotationComposer extends Composer<_$AppDatabase, $ItemEventsTable> {
  $$ItemEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

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
          _$AppDatabase,
          $ItemEventsTable,
          ItemEventRow,
          $$ItemEventsTableFilterComposer,
          $$ItemEventsTableOrderingComposer,
          $$ItemEventsTableAnnotationComposer,
          $$ItemEventsTableCreateCompanionBuilder,
          $$ItemEventsTableUpdateCompanionBuilder,
          (ItemEventRow, BaseReferences<_$AppDatabase, $ItemEventsTable, ItemEventRow>),
          ItemEventRow,
          PrefetchHooks Function()
        > {
  $$ItemEventsTableTableManager(_$AppDatabase db, $ItemEventsTable table)
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
                Value<int> profileId = const Value.absent(),
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
                profileId: profileId,
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
                Value<int> profileId = const Value.absent(),
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
                profileId: profileId,
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
                  BaseReferences<_$AppDatabase, $ItemEventsTable, ItemEventRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemEventsTable,
      ItemEventRow,
      $$ItemEventsTableFilterComposer,
      $$ItemEventsTableOrderingComposer,
      $$ItemEventsTableAnnotationComposer,
      $$ItemEventsTableCreateCompanionBuilder,
      $$ItemEventsTableUpdateCompanionBuilder,
      (ItemEventRow, BaseReferences<_$AppDatabase, $ItemEventsTable, ItemEventRow>),
      ItemEventRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles => $$ProfilesTableTableManager(_db, _db.profiles);
  $$CompletedStepsTableTableManager get completedSteps =>
      $$CompletedStepsTableTableManager(_db, _db.completedSteps);
  $$PlayedGamesTableTableManager get playedGames =>
      $$PlayedGamesTableTableManager(_db, _db.playedGames);
  $$ItemEventsTableTableManager get itemEvents =>
      $$ItemEventsTableTableManager(_db, _db.itemEvents);
}
