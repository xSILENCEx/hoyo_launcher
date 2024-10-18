// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// ignore_for_file: type=lint
class $GameInfoTableTable extends GameInfoTable
    with TableInfo<$GameInfoTableTable, GameInfoDBModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _launchPathMeta =
      const VerificationMeta('launchPath');
  @override
  late final GeneratedColumn<String> launchPath = GeneratedColumn<String>(
      'launch_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _moreActionsMeta =
      const VerificationMeta('moreActions');
  @override
  late final GeneratedColumn<String> moreActions = GeneratedColumn<String>(
      'more_actions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTimeMeta =
      const VerificationMeta('updateTime');
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
      'update_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sortValueMeta =
      const VerificationMeta('sortValue');
  @override
  late final GeneratedColumn<int> sortValue = GeneratedColumn<int>(
      'sort_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        icon,
        title,
        launchPath,
        moreActions,
        createTime,
        updateTime,
        sortValue
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_info_table';
  @override
  VerificationContext validateIntegrity(Insertable<GameInfoDBModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('launch_path')) {
      context.handle(
          _launchPathMeta,
          launchPath.isAcceptableOrUnknown(
              data['launch_path']!, _launchPathMeta));
    } else if (isInserting) {
      context.missing(_launchPathMeta);
    }
    if (data.containsKey('more_actions')) {
      context.handle(
          _moreActionsMeta,
          moreActions.isAcceptableOrUnknown(
              data['more_actions']!, _moreActionsMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
          _updateTimeMeta,
          updateTime.isAcceptableOrUnknown(
              data['update_time']!, _updateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    if (data.containsKey('sort_value')) {
      context.handle(_sortValueMeta,
          sortValue.isAcceptableOrUnknown(data['sort_value']!, _sortValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameInfoDBModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameInfoDBModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      launchPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}launch_path'])!,
      moreActions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}more_actions']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_time'])!,
      sortValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_value']),
    );
  }

  @override
  $GameInfoTableTable createAlias(String alias) {
    return $GameInfoTableTable(attachedDatabase, alias);
  }
}

class GameInfoDBModel extends DataClass implements Insertable<GameInfoDBModel> {
  /// * [id] 游戏ID
  final String id;

  /// * [icon] 游戏图标
  final String icon;

  /// * [title] 游戏标题
  final String title;

  /// * [launchPath] 游戏启动路径
  final String launchPath;

  /// * [moreActions] 更多操作
  final String? moreActions;

  /// * [createTime] 创建时间
  final DateTime createTime;

  /// * [updateTime] 更新时间
  final DateTime updateTime;

  /// * [sortValue] 排序值
  final int? sortValue;
  const GameInfoDBModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.launchPath,
      this.moreActions,
      required this.createTime,
      required this.updateTime,
      this.sortValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['icon'] = Variable<String>(icon);
    map['title'] = Variable<String>(title);
    map['launch_path'] = Variable<String>(launchPath);
    if (!nullToAbsent || moreActions != null) {
      map['more_actions'] = Variable<String>(moreActions);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    map['update_time'] = Variable<DateTime>(updateTime);
    if (!nullToAbsent || sortValue != null) {
      map['sort_value'] = Variable<int>(sortValue);
    }
    return map;
  }

  GameInfoTableCompanion toCompanion(bool nullToAbsent) {
    return GameInfoTableCompanion(
      id: Value(id),
      icon: Value(icon),
      title: Value(title),
      launchPath: Value(launchPath),
      moreActions: moreActions == null && nullToAbsent
          ? const Value.absent()
          : Value(moreActions),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      sortValue: sortValue == null && nullToAbsent
          ? const Value.absent()
          : Value(sortValue),
    );
  }

  factory GameInfoDBModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameInfoDBModel(
      id: serializer.fromJson<String>(json['id']),
      icon: serializer.fromJson<String>(json['icon']),
      title: serializer.fromJson<String>(json['title']),
      launchPath: serializer.fromJson<String>(json['launchPath']),
      moreActions: serializer.fromJson<String?>(json['moreActions']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
      sortValue: serializer.fromJson<int?>(json['sortValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'icon': serializer.toJson<String>(icon),
      'title': serializer.toJson<String>(title),
      'launchPath': serializer.toJson<String>(launchPath),
      'moreActions': serializer.toJson<String?>(moreActions),
      'createTime': serializer.toJson<DateTime>(createTime),
      'updateTime': serializer.toJson<DateTime>(updateTime),
      'sortValue': serializer.toJson<int?>(sortValue),
    };
  }

  GameInfoDBModel copyWith(
          {String? id,
          String? icon,
          String? title,
          String? launchPath,
          Value<String?> moreActions = const Value.absent(),
          DateTime? createTime,
          DateTime? updateTime,
          Value<int?> sortValue = const Value.absent()}) =>
      GameInfoDBModel(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        title: title ?? this.title,
        launchPath: launchPath ?? this.launchPath,
        moreActions: moreActions.present ? moreActions.value : this.moreActions,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        sortValue: sortValue.present ? sortValue.value : this.sortValue,
      );
  GameInfoDBModel copyWithCompanion(GameInfoTableCompanion data) {
    return GameInfoDBModel(
      id: data.id.present ? data.id.value : this.id,
      icon: data.icon.present ? data.icon.value : this.icon,
      title: data.title.present ? data.title.value : this.title,
      launchPath:
          data.launchPath.present ? data.launchPath.value : this.launchPath,
      moreActions:
          data.moreActions.present ? data.moreActions.value : this.moreActions,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      sortValue: data.sortValue.present ? data.sortValue.value : this.sortValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameInfoDBModel(')
          ..write('id: $id, ')
          ..write('icon: $icon, ')
          ..write('title: $title, ')
          ..write('launchPath: $launchPath, ')
          ..write('moreActions: $moreActions, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('sortValue: $sortValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, icon, title, launchPath, moreActions,
      createTime, updateTime, sortValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameInfoDBModel &&
          other.id == this.id &&
          other.icon == this.icon &&
          other.title == this.title &&
          other.launchPath == this.launchPath &&
          other.moreActions == this.moreActions &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.sortValue == this.sortValue);
}

class GameInfoTableCompanion extends UpdateCompanion<GameInfoDBModel> {
  final Value<String> id;
  final Value<String> icon;
  final Value<String> title;
  final Value<String> launchPath;
  final Value<String?> moreActions;
  final Value<DateTime> createTime;
  final Value<DateTime> updateTime;
  final Value<int?> sortValue;
  final Value<int> rowid;
  const GameInfoTableCompanion({
    this.id = const Value.absent(),
    this.icon = const Value.absent(),
    this.title = const Value.absent(),
    this.launchPath = const Value.absent(),
    this.moreActions = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.sortValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameInfoTableCompanion.insert({
    required String id,
    required String icon,
    required String title,
    required String launchPath,
    this.moreActions = const Value.absent(),
    required DateTime createTime,
    required DateTime updateTime,
    this.sortValue = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        icon = Value(icon),
        title = Value(title),
        launchPath = Value(launchPath),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<GameInfoDBModel> custom({
    Expression<String>? id,
    Expression<String>? icon,
    Expression<String>? title,
    Expression<String>? launchPath,
    Expression<String>? moreActions,
    Expression<DateTime>? createTime,
    Expression<DateTime>? updateTime,
    Expression<int>? sortValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (icon != null) 'icon': icon,
      if (title != null) 'title': title,
      if (launchPath != null) 'launch_path': launchPath,
      if (moreActions != null) 'more_actions': moreActions,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (sortValue != null) 'sort_value': sortValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameInfoTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? icon,
      Value<String>? title,
      Value<String>? launchPath,
      Value<String?>? moreActions,
      Value<DateTime>? createTime,
      Value<DateTime>? updateTime,
      Value<int?>? sortValue,
      Value<int>? rowid}) {
    return GameInfoTableCompanion(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      launchPath: launchPath ?? this.launchPath,
      moreActions: moreActions ?? this.moreActions,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      sortValue: sortValue ?? this.sortValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (launchPath.present) {
      map['launch_path'] = Variable<String>(launchPath.value);
    }
    if (moreActions.present) {
      map['more_actions'] = Variable<String>(moreActions.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    if (sortValue.present) {
      map['sort_value'] = Variable<int>(sortValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('icon: $icon, ')
          ..write('title: $title, ')
          ..write('launchPath: $launchPath, ')
          ..write('moreActions: $moreActions, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('sortValue: $sortValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameInfoBgTableTable extends GameInfoBgTable
    with TableInfo<$GameInfoBgTableTable, GameInfoBgDBModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameInfoBgTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _animatDuratuionMeta =
      const VerificationMeta('animatDuratuion');
  @override
  late final GeneratedColumn<int> animatDuratuion = GeneratedColumn<int>(
      'animat_duratuion', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _randomMeta = const VerificationMeta('random');
  @override
  late final GeneratedColumn<bool> random = GeneratedColumn<bool>(
      'random', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("random" IN (0, 1))'));
  static const VerificationMeta _bgDataMeta = const VerificationMeta('bgData');
  @override
  late final GeneratedColumn<String> bgData = GeneratedColumn<String>(
      'bg_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, duration, animatDuratuion, random, bgData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_info_bg_table';
  @override
  VerificationContext validateIntegrity(Insertable<GameInfoBgDBModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('animat_duratuion')) {
      context.handle(
          _animatDuratuionMeta,
          animatDuratuion.isAcceptableOrUnknown(
              data['animat_duratuion']!, _animatDuratuionMeta));
    } else if (isInserting) {
      context.missing(_animatDuratuionMeta);
    }
    if (data.containsKey('random')) {
      context.handle(_randomMeta,
          random.isAcceptableOrUnknown(data['random']!, _randomMeta));
    }
    if (data.containsKey('bg_data')) {
      context.handle(_bgDataMeta,
          bgData.isAcceptableOrUnknown(data['bg_data']!, _bgDataMeta));
    } else if (isInserting) {
      context.missing(_bgDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameInfoBgDBModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameInfoBgDBModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      animatDuratuion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}animat_duratuion'])!,
      random: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}random']),
      bgData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bg_data'])!,
    );
  }

  @override
  $GameInfoBgTableTable createAlias(String alias) {
    return $GameInfoBgTableTable(attachedDatabase, alias);
  }
}

class GameInfoBgDBModel extends DataClass
    implements Insertable<GameInfoBgDBModel> {
  /// * [id] 游戏ID
  final String id;

  /// * [duration] 切换间隔时间
  final int duration;

  /// * [animatDuratuion] 过度动画时长
  final int animatDuratuion;

  /// * 随机切换
  final bool? random;

  /// * [bgData] 背景数据
  final String bgData;
  const GameInfoBgDBModel(
      {required this.id,
      required this.duration,
      required this.animatDuratuion,
      this.random,
      required this.bgData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['duration'] = Variable<int>(duration);
    map['animat_duratuion'] = Variable<int>(animatDuratuion);
    if (!nullToAbsent || random != null) {
      map['random'] = Variable<bool>(random);
    }
    map['bg_data'] = Variable<String>(bgData);
    return map;
  }

  GameInfoBgTableCompanion toCompanion(bool nullToAbsent) {
    return GameInfoBgTableCompanion(
      id: Value(id),
      duration: Value(duration),
      animatDuratuion: Value(animatDuratuion),
      random:
          random == null && nullToAbsent ? const Value.absent() : Value(random),
      bgData: Value(bgData),
    );
  }

  factory GameInfoBgDBModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameInfoBgDBModel(
      id: serializer.fromJson<String>(json['id']),
      duration: serializer.fromJson<int>(json['duration']),
      animatDuratuion: serializer.fromJson<int>(json['animatDuratuion']),
      random: serializer.fromJson<bool?>(json['random']),
      bgData: serializer.fromJson<String>(json['bgData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'duration': serializer.toJson<int>(duration),
      'animatDuratuion': serializer.toJson<int>(animatDuratuion),
      'random': serializer.toJson<bool?>(random),
      'bgData': serializer.toJson<String>(bgData),
    };
  }

  GameInfoBgDBModel copyWith(
          {String? id,
          int? duration,
          int? animatDuratuion,
          Value<bool?> random = const Value.absent(),
          String? bgData}) =>
      GameInfoBgDBModel(
        id: id ?? this.id,
        duration: duration ?? this.duration,
        animatDuratuion: animatDuratuion ?? this.animatDuratuion,
        random: random.present ? random.value : this.random,
        bgData: bgData ?? this.bgData,
      );
  GameInfoBgDBModel copyWithCompanion(GameInfoBgTableCompanion data) {
    return GameInfoBgDBModel(
      id: data.id.present ? data.id.value : this.id,
      duration: data.duration.present ? data.duration.value : this.duration,
      animatDuratuion: data.animatDuratuion.present
          ? data.animatDuratuion.value
          : this.animatDuratuion,
      random: data.random.present ? data.random.value : this.random,
      bgData: data.bgData.present ? data.bgData.value : this.bgData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameInfoBgDBModel(')
          ..write('id: $id, ')
          ..write('duration: $duration, ')
          ..write('animatDuratuion: $animatDuratuion, ')
          ..write('random: $random, ')
          ..write('bgData: $bgData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, duration, animatDuratuion, random, bgData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameInfoBgDBModel &&
          other.id == this.id &&
          other.duration == this.duration &&
          other.animatDuratuion == this.animatDuratuion &&
          other.random == this.random &&
          other.bgData == this.bgData);
}

class GameInfoBgTableCompanion extends UpdateCompanion<GameInfoBgDBModel> {
  final Value<String> id;
  final Value<int> duration;
  final Value<int> animatDuratuion;
  final Value<bool?> random;
  final Value<String> bgData;
  final Value<int> rowid;
  const GameInfoBgTableCompanion({
    this.id = const Value.absent(),
    this.duration = const Value.absent(),
    this.animatDuratuion = const Value.absent(),
    this.random = const Value.absent(),
    this.bgData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameInfoBgTableCompanion.insert({
    required String id,
    required int duration,
    required int animatDuratuion,
    this.random = const Value.absent(),
    required String bgData,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        duration = Value(duration),
        animatDuratuion = Value(animatDuratuion),
        bgData = Value(bgData);
  static Insertable<GameInfoBgDBModel> custom({
    Expression<String>? id,
    Expression<int>? duration,
    Expression<int>? animatDuratuion,
    Expression<bool>? random,
    Expression<String>? bgData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (duration != null) 'duration': duration,
      if (animatDuratuion != null) 'animat_duratuion': animatDuratuion,
      if (random != null) 'random': random,
      if (bgData != null) 'bg_data': bgData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameInfoBgTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? duration,
      Value<int>? animatDuratuion,
      Value<bool?>? random,
      Value<String>? bgData,
      Value<int>? rowid}) {
    return GameInfoBgTableCompanion(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      animatDuratuion: animatDuratuion ?? this.animatDuratuion,
      random: random ?? this.random,
      bgData: bgData ?? this.bgData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (animatDuratuion.present) {
      map['animat_duratuion'] = Variable<int>(animatDuratuion.value);
    }
    if (random.present) {
      map['random'] = Variable<bool>(random.value);
    }
    if (bgData.present) {
      map['bg_data'] = Variable<String>(bgData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameInfoBgTableCompanion(')
          ..write('id: $id, ')
          ..write('duration: $duration, ')
          ..write('animatDuratuion: $animatDuratuion, ')
          ..write('random: $random, ')
          ..write('bgData: $bgData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  $MyDatabaseManager get managers => $MyDatabaseManager(this);
  late final $GameInfoTableTable gameInfoTable = $GameInfoTableTable(this);
  late final $GameInfoBgTableTable gameInfoBgTable =
      $GameInfoBgTableTable(this);
  late final GameInfoDao gameInfoDao = GameInfoDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [gameInfoTable, gameInfoBgTable];
}

typedef $$GameInfoTableTableCreateCompanionBuilder = GameInfoTableCompanion
    Function({
  required String id,
  required String icon,
  required String title,
  required String launchPath,
  Value<String?> moreActions,
  required DateTime createTime,
  required DateTime updateTime,
  Value<int?> sortValue,
  Value<int> rowid,
});
typedef $$GameInfoTableTableUpdateCompanionBuilder = GameInfoTableCompanion
    Function({
  Value<String> id,
  Value<String> icon,
  Value<String> title,
  Value<String> launchPath,
  Value<String?> moreActions,
  Value<DateTime> createTime,
  Value<DateTime> updateTime,
  Value<int?> sortValue,
  Value<int> rowid,
});

class $$GameInfoTableTableFilterComposer
    extends Composer<_$MyDatabase, $GameInfoTableTable> {
  $$GameInfoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get launchPath => $composableBuilder(
      column: $table.launchPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get moreActions => $composableBuilder(
      column: $table.moreActions, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortValue => $composableBuilder(
      column: $table.sortValue, builder: (column) => ColumnFilters(column));
}

class $$GameInfoTableTableOrderingComposer
    extends Composer<_$MyDatabase, $GameInfoTableTable> {
  $$GameInfoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get launchPath => $composableBuilder(
      column: $table.launchPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moreActions => $composableBuilder(
      column: $table.moreActions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortValue => $composableBuilder(
      column: $table.sortValue, builder: (column) => ColumnOrderings(column));
}

class $$GameInfoTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $GameInfoTableTable> {
  $$GameInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get launchPath => $composableBuilder(
      column: $table.launchPath, builder: (column) => column);

  GeneratedColumn<String> get moreActions => $composableBuilder(
      column: $table.moreActions, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<int> get sortValue =>
      $composableBuilder(column: $table.sortValue, builder: (column) => column);
}

class $$GameInfoTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $GameInfoTableTable,
    GameInfoDBModel,
    $$GameInfoTableTableFilterComposer,
    $$GameInfoTableTableOrderingComposer,
    $$GameInfoTableTableAnnotationComposer,
    $$GameInfoTableTableCreateCompanionBuilder,
    $$GameInfoTableTableUpdateCompanionBuilder,
    (
      GameInfoDBModel,
      BaseReferences<_$MyDatabase, $GameInfoTableTable, GameInfoDBModel>
    ),
    GameInfoDBModel,
    PrefetchHooks Function()> {
  $$GameInfoTableTableTableManager(_$MyDatabase db, $GameInfoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameInfoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameInfoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameInfoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> launchPath = const Value.absent(),
            Value<String?> moreActions = const Value.absent(),
            Value<DateTime> createTime = const Value.absent(),
            Value<DateTime> updateTime = const Value.absent(),
            Value<int?> sortValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameInfoTableCompanion(
            id: id,
            icon: icon,
            title: title,
            launchPath: launchPath,
            moreActions: moreActions,
            createTime: createTime,
            updateTime: updateTime,
            sortValue: sortValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String icon,
            required String title,
            required String launchPath,
            Value<String?> moreActions = const Value.absent(),
            required DateTime createTime,
            required DateTime updateTime,
            Value<int?> sortValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameInfoTableCompanion.insert(
            id: id,
            icon: icon,
            title: title,
            launchPath: launchPath,
            moreActions: moreActions,
            createTime: createTime,
            updateTime: updateTime,
            sortValue: sortValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GameInfoTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $GameInfoTableTable,
    GameInfoDBModel,
    $$GameInfoTableTableFilterComposer,
    $$GameInfoTableTableOrderingComposer,
    $$GameInfoTableTableAnnotationComposer,
    $$GameInfoTableTableCreateCompanionBuilder,
    $$GameInfoTableTableUpdateCompanionBuilder,
    (
      GameInfoDBModel,
      BaseReferences<_$MyDatabase, $GameInfoTableTable, GameInfoDBModel>
    ),
    GameInfoDBModel,
    PrefetchHooks Function()>;
typedef $$GameInfoBgTableTableCreateCompanionBuilder = GameInfoBgTableCompanion
    Function({
  required String id,
  required int duration,
  required int animatDuratuion,
  Value<bool?> random,
  required String bgData,
  Value<int> rowid,
});
typedef $$GameInfoBgTableTableUpdateCompanionBuilder = GameInfoBgTableCompanion
    Function({
  Value<String> id,
  Value<int> duration,
  Value<int> animatDuratuion,
  Value<bool?> random,
  Value<String> bgData,
  Value<int> rowid,
});

class $$GameInfoBgTableTableFilterComposer
    extends Composer<_$MyDatabase, $GameInfoBgTableTable> {
  $$GameInfoBgTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get animatDuratuion => $composableBuilder(
      column: $table.animatDuratuion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get random => $composableBuilder(
      column: $table.random, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bgData => $composableBuilder(
      column: $table.bgData, builder: (column) => ColumnFilters(column));
}

class $$GameInfoBgTableTableOrderingComposer
    extends Composer<_$MyDatabase, $GameInfoBgTableTable> {
  $$GameInfoBgTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get animatDuratuion => $composableBuilder(
      column: $table.animatDuratuion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get random => $composableBuilder(
      column: $table.random, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bgData => $composableBuilder(
      column: $table.bgData, builder: (column) => ColumnOrderings(column));
}

class $$GameInfoBgTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $GameInfoBgTableTable> {
  $$GameInfoBgTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get animatDuratuion => $composableBuilder(
      column: $table.animatDuratuion, builder: (column) => column);

  GeneratedColumn<bool> get random =>
      $composableBuilder(column: $table.random, builder: (column) => column);

  GeneratedColumn<String> get bgData =>
      $composableBuilder(column: $table.bgData, builder: (column) => column);
}

class $$GameInfoBgTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $GameInfoBgTableTable,
    GameInfoBgDBModel,
    $$GameInfoBgTableTableFilterComposer,
    $$GameInfoBgTableTableOrderingComposer,
    $$GameInfoBgTableTableAnnotationComposer,
    $$GameInfoBgTableTableCreateCompanionBuilder,
    $$GameInfoBgTableTableUpdateCompanionBuilder,
    (
      GameInfoBgDBModel,
      BaseReferences<_$MyDatabase, $GameInfoBgTableTable, GameInfoBgDBModel>
    ),
    GameInfoBgDBModel,
    PrefetchHooks Function()> {
  $$GameInfoBgTableTableTableManager(
      _$MyDatabase db, $GameInfoBgTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameInfoBgTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameInfoBgTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameInfoBgTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<int> animatDuratuion = const Value.absent(),
            Value<bool?> random = const Value.absent(),
            Value<String> bgData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameInfoBgTableCompanion(
            id: id,
            duration: duration,
            animatDuratuion: animatDuratuion,
            random: random,
            bgData: bgData,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int duration,
            required int animatDuratuion,
            Value<bool?> random = const Value.absent(),
            required String bgData,
            Value<int> rowid = const Value.absent(),
          }) =>
              GameInfoBgTableCompanion.insert(
            id: id,
            duration: duration,
            animatDuratuion: animatDuratuion,
            random: random,
            bgData: bgData,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GameInfoBgTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $GameInfoBgTableTable,
    GameInfoBgDBModel,
    $$GameInfoBgTableTableFilterComposer,
    $$GameInfoBgTableTableOrderingComposer,
    $$GameInfoBgTableTableAnnotationComposer,
    $$GameInfoBgTableTableCreateCompanionBuilder,
    $$GameInfoBgTableTableUpdateCompanionBuilder,
    (
      GameInfoBgDBModel,
      BaseReferences<_$MyDatabase, $GameInfoBgTableTable, GameInfoBgDBModel>
    ),
    GameInfoBgDBModel,
    PrefetchHooks Function()>;

class $MyDatabaseManager {
  final _$MyDatabase _db;
  $MyDatabaseManager(this._db);
  $$GameInfoTableTableTableManager get gameInfoTable =>
      $$GameInfoTableTableTableManager(_db, _db.gameInfoTable);
  $$GameInfoBgTableTableTableManager get gameInfoBgTable =>
      $$GameInfoBgTableTableTableManager(_db, _db.gameInfoBgTable);
}
