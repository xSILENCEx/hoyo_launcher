import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

///   日志等级
/// * [debug] 调试
/// * [info] 信息
/// * [warning] 警告
/// * [error] 错误
enum LOGLEVEL { debug, info, warning, error }

///日志等级枚举扩展
extension LogLevelExtension on LOGLEVEL {
  ///获取tag
  String get tag {
    switch (this) {
      case LOGLEVEL.debug:
        return '[DEBUG]   ';
      case LOGLEVEL.info:
        return '[INFO]    ';
      case LOGLEVEL.warning:
        return '[WARNING] ';
      case LOGLEVEL.error:
        return '[ERROR]   ';
    }
  }

  ///获取颜色代码
  int get code {
    switch (this) {
      case LOGLEVEL.debug:
        return 5;
      case LOGLEVEL.info:
        return 2;
      case LOGLEVEL.warning:
        return 3;
      case LOGLEVEL.error:
        return 1;
    }
  }

  Color get color {
    switch (this) {
      case LOGLEVEL.debug:
        return Colors.blue;
      case LOGLEVEL.info:
        return Colors.green;
      case LOGLEVEL.warning:
        return Colors.orange;
      case LOGLEVEL.error:
        return Colors.red;
    }
  }
}

/// 日志输出封装
class L {
  L._();

  ///顶部图案
  static String get _pic {
    return '''

         ┌─┐       ┌─┐
      ┌──┘ ┴───────┘ ┴──┐
      │                 │
      │       ───       │
      │  ─┬┘       └┬─  │
      │                 │
      │       ─┴─       │
      │                 │
      └───┐         ┌───┘
          │         │ 神兽保佑
          │         │ 永无BUG
          │         │
          │         └──────────────┐
          │                        │
          │                        ├─┐
          │                        ┌─┘
          │                        │
          └─┐  ┐  ┌───────┬──┐  ┌──┘
            │ ─┤ ─┤       │ ─┤ ─┤
            └──┴──┘       └──┴──┘
  ''';
  }

  ///开发者标识
  static String _tag = 'DEFAULT';

  ///初始化函数
  static void init({String? tag}) {
    _tag = tag ?? _tag;
    infoLog(_pic, showPath: false);
  }

  ///日志着色
  static String _logColor(dynamic info, {int color = 7}) {
    return '\x1B[9${color}m$info\x1B[0m';
    // return info.toString();
  }

  ///打印信息
  static void _log(
    dynamic content, {
    LOGLEVEL lv = LOGLEVEL.info,
    bool showPath = true,
    int stackIndex = 3,
  }) {
    assert(() {
      final String time = DateTime.now().toString().split('.')[0];
      final String currentStack = 'package${StackTrace.current.toString().split('\n')[stackIndex].split('package')[1]}';
      final String avatar = _logColor(lv.tag, color: lv.code);
      final String stackHeader = _logColor('[PATH]    ', color: lv.code);

      dev.log(avatar + _logColor(content.toString(), color: lv == LOGLEVEL.error ? lv.code : 7), name: time);
      if (showPath) {
        dev.log(
          '$stackHeader${StackTrace.fromString('\t$currentStack').toString().replaceAll(')', '')}\n',
          name: time,
        );
      }

      return true;
    }());
  }
}

/// debug级别日志
void debugLog(dynamic msg, {bool showPath = true, int stackIndex = 3}) => L._log(
      msg,
      lv: LOGLEVEL.debug,
      showPath: showPath,
      stackIndex: stackIndex,
    );

/// info级别日志
void infoLog(dynamic msg, {bool showPath = true, int stackIndex = 3}) => L._log(
      msg,
      showPath: showPath,
      stackIndex: stackIndex,
    );

/// warning级别日志
void warningLog(dynamic msg, {bool showPath = true, int stackIndex = 3}) => L._log(
      msg,
      lv: LOGLEVEL.warning,
      showPath: showPath,
      stackIndex: stackIndex,
    );

/// error级别日志
void errorLog(dynamic msg, {bool showPath = true, int stackIndex = 3}) => L._log(
      msg,
      lv: LOGLEVEL.error,
      showPath: showPath,
      stackIndex: stackIndex,
    );

/// 原始日志
void originLog(dynamic msg) => dev.log(msg.toString());

/// json序列化
String gpsJsonEncode(Object? value) {
  try {
    return const JsonEncoder.withIndent(' ').convert(value);
  } catch (e) {
    return value.toString();
  }
}
