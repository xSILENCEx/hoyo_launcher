import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hoyo_launcher/commons/logger.dart';

/// 本地存储相关
class LocalStorage {
  const LocalStorage._();

  static late Box<dynamic> _appBox;
  static bool _isInit = false;

  /// 初始化
  static Future<void> init() async {
    try {
      if (_isInit) {
        return;
      }

      Hive.init('$appDirectoryPath\\hive');
      _appBox = await Hive.openBox<dynamic>('appBox');

      _isInit = true;
    } catch (e) {
      errorLog('init hive box error $e');
    }
  }

  /// 抓取值
  static T? getV<T extends Object>(dynamic key) {
    try {
      return _appBox.get(key) as T?;
    } catch (e) {
      errorLog('get value error $e');
    }
    return null;
  }

  /// 存储值
  static void setV(String key, dynamic value) {
    try {
      _appBox.put(key, value);
    } catch (e) {
      errorLog('save value error $e');
    }
  }

  /// 删除值
  static void delV<T extends Object>(String key) {
    try {
      _appBox.delete(key);
    } catch (e) {
      errorLog('save value error $e');
    }
  }

  /// 添加值
  static void addV<T extends HiveObject>(T value) {
    try {
      _appBox.add(value);
    } catch (e) {
      errorLog('save Object error $e');
    }
  }

  /// 获取值
  static T? getAt<T extends HiveObject>(int typeId) {
    try {
      return _appBox.getAt(typeId) as T?;
    } catch (e) {
      errorLog('getAt Object error $e');
      return null;
    }
  }

  /// 获取全部值
  static Iterable<dynamic>? getAllValue() {
    try {
      return _appBox.values;
    } catch (e) {
      errorLog('get all values error $e');
      return null;
    }
  }

  /// 清空
  static Future<int> clear() async {
    try {
      return await _appBox.clear();
    } catch (e) {
      errorLog('clear hive error $e');
    }

    return 0;
  }
}

String get appDirectoryPath {
  if (kDebugMode) {
    return '${Directory.current.path}\\build\\windows\\x64\\runner\\Debug';
  } else {
    return Directory.current.path;
  }
}
