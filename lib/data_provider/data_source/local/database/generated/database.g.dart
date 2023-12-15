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
  static const VerificationMeta _gameBgTypeMeta =
      const VerificationMeta('gameBgType');
  @override
  late final GeneratedColumn<String> gameBgType = GeneratedColumn<String>(
      'game_bg_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backgroundMeta =
      const VerificationMeta('background');
  @override
  late final GeneratedColumn<String> background = GeneratedColumn<String>(
      'background', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _launcherPathMeta =
      const VerificationMeta('launcherPath');
  @override
  late final GeneratedColumn<String> launcherPath = GeneratedColumn<String>(
      'launcher_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        icon,
        title,
        launchPath,
        createTime,
        updateTime,
        gameBgType,
        background,
        launcherPath
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
    if (data.containsKey('game_bg_type')) {
      context.handle(
          _gameBgTypeMeta,
          gameBgType.isAcceptableOrUnknown(
              data['game_bg_type']!, _gameBgTypeMeta));
    }
    if (data.containsKey('background')) {
      context.handle(
          _backgroundMeta,
          background.isAcceptableOrUnknown(
              data['background']!, _backgroundMeta));
    }
    if (data.containsKey('launcher_path')) {
      context.handle(
          _launcherPathMeta,
          launcherPath.isAcceptableOrUnknown(
              data['launcher_path']!, _launcherPathMeta));
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
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_time'])!,
      gameBgType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game_bg_type']),
      background: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}background']),
      launcherPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}launcher_path']),
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

  /// * [createTime] 创建时间
  final DateTime createTime;

  /// * [updateTime] 更新时间
  final DateTime updateTime;

  /// * [gameBgType] 游戏背景类型
  final String? gameBgType;

  /// * [background] 游戏背景
  final String? background;

  /// * [launcherPath] 游戏启动器路径
  final String? launcherPath;
  const GameInfoDBModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.launchPath,
      required this.createTime,
      required this.updateTime,
      this.gameBgType,
      this.background,
      this.launcherPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['icon'] = Variable<String>(icon);
    map['title'] = Variable<String>(title);
    map['launch_path'] = Variable<String>(launchPath);
    map['create_time'] = Variable<DateTime>(createTime);
    map['update_time'] = Variable<DateTime>(updateTime);
    if (!nullToAbsent || gameBgType != null) {
      map['game_bg_type'] = Variable<String>(gameBgType);
    }
    if (!nullToAbsent || background != null) {
      map['background'] = Variable<String>(background);
    }
    if (!nullToAbsent || launcherPath != null) {
      map['launcher_path'] = Variable<String>(launcherPath);
    }
    return map;
  }

  GameInfoTableCompanion toCompanion(bool nullToAbsent) {
    return GameInfoTableCompanion(
      id: Value(id),
      icon: Value(icon),
      title: Value(title),
      launchPath: Value(launchPath),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      gameBgType: gameBgType == null && nullToAbsent
          ? const Value.absent()
          : Value(gameBgType),
      background: background == null && nullToAbsent
          ? const Value.absent()
          : Value(background),
      launcherPath: launcherPath == null && nullToAbsent
          ? const Value.absent()
          : Value(launcherPath),
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
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
      gameBgType: serializer.fromJson<String?>(json['gameBgType']),
      background: serializer.fromJson<String?>(json['background']),
      launcherPath: serializer.fromJson<String?>(json['launcherPath']),
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
      'createTime': serializer.toJson<DateTime>(createTime),
      'updateTime': serializer.toJson<DateTime>(updateTime),
      'gameBgType': serializer.toJson<String?>(gameBgType),
      'background': serializer.toJson<String?>(background),
      'launcherPath': serializer.toJson<String?>(launcherPath),
    };
  }

  GameInfoDBModel copyWith(
          {String? id,
          String? icon,
          String? title,
          String? launchPath,
          DateTime? createTime,
          DateTime? updateTime,
          Value<String?> gameBgType = const Value.absent(),
          Value<String?> background = const Value.absent(),
          Value<String?> launcherPath = const Value.absent()}) =>
      GameInfoDBModel(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        title: title ?? this.title,
        launchPath: launchPath ?? this.launchPath,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        gameBgType: gameBgType.present ? gameBgType.value : this.gameBgType,
        background: background.present ? background.value : this.background,
        launcherPath:
            launcherPath.present ? launcherPath.value : this.launcherPath,
      );
  @override
  String toString() {
    return (StringBuffer('GameInfoDBModel(')
          ..write('id: $id, ')
          ..write('icon: $icon, ')
          ..write('title: $title, ')
          ..write('launchPath: $launchPath, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('gameBgType: $gameBgType, ')
          ..write('background: $background, ')
          ..write('launcherPath: $launcherPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, icon, title, launchPath, createTime,
      updateTime, gameBgType, background, launcherPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameInfoDBModel &&
          other.id == this.id &&
          other.icon == this.icon &&
          other.title == this.title &&
          other.launchPath == this.launchPath &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.gameBgType == this.gameBgType &&
          other.background == this.background &&
          other.launcherPath == this.launcherPath);
}

class GameInfoTableCompanion extends UpdateCompanion<GameInfoDBModel> {
  final Value<String> id;
  final Value<String> icon;
  final Value<String> title;
  final Value<String> launchPath;
  final Value<DateTime> createTime;
  final Value<DateTime> updateTime;
  final Value<String?> gameBgType;
  final Value<String?> background;
  final Value<String?> launcherPath;
  final Value<int> rowid;
  const GameInfoTableCompanion({
    this.id = const Value.absent(),
    this.icon = const Value.absent(),
    this.title = const Value.absent(),
    this.launchPath = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.gameBgType = const Value.absent(),
    this.background = const Value.absent(),
    this.launcherPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameInfoTableCompanion.insert({
    required String id,
    required String icon,
    required String title,
    required String launchPath,
    required DateTime createTime,
    required DateTime updateTime,
    this.gameBgType = const Value.absent(),
    this.background = const Value.absent(),
    this.launcherPath = const Value.absent(),
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
    Expression<DateTime>? createTime,
    Expression<DateTime>? updateTime,
    Expression<String>? gameBgType,
    Expression<String>? background,
    Expression<String>? launcherPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (icon != null) 'icon': icon,
      if (title != null) 'title': title,
      if (launchPath != null) 'launch_path': launchPath,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (gameBgType != null) 'game_bg_type': gameBgType,
      if (background != null) 'background': background,
      if (launcherPath != null) 'launcher_path': launcherPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameInfoTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? icon,
      Value<String>? title,
      Value<String>? launchPath,
      Value<DateTime>? createTime,
      Value<DateTime>? updateTime,
      Value<String?>? gameBgType,
      Value<String?>? background,
      Value<String?>? launcherPath,
      Value<int>? rowid}) {
    return GameInfoTableCompanion(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      launchPath: launchPath ?? this.launchPath,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      gameBgType: gameBgType ?? this.gameBgType,
      background: background ?? this.background,
      launcherPath: launcherPath ?? this.launcherPath,
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
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    if (gameBgType.present) {
      map['game_bg_type'] = Variable<String>(gameBgType.value);
    }
    if (background.present) {
      map['background'] = Variable<String>(background.value);
    }
    if (launcherPath.present) {
      map['launcher_path'] = Variable<String>(launcherPath.value);
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
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('gameBgType: $gameBgType, ')
          ..write('background: $background, ')
          ..write('launcherPath: $launcherPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $GameInfoTableTable gameInfoTable = $GameInfoTableTable(this);
  late final GameInfoDao gameInfoDao = GameInfoDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gameInfoTable];
}
