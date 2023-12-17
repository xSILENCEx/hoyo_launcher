import 'package:flutter/material.dart';
import 'package:hoyo_launcher/commons/logger.dart';

typedef ExOnData<T> = Function(T p, T n);

///ValueNotifier安全扩展
class ExValue<T> extends ValueNotifier<T> {
  ExValue(T value) : super(value);

  bool _mounted = true;

  final List<ExOnData<T>> _onDataList = <ExOnData<T>>[];

  void addCallback(ExOnData<T> onData) {
    _onDataList.add(onData);
  }

  void removeCallback(ExOnData<T> onData) {
    _onDataList.remove(onData);
  }

  @override
  set value(T newValue) {
    if (_mounted) {
      if (value != newValue) {
        final T oldValue = value;

        for (final ExOnData<T> onData in _onDataList) {
          try {
            onData(oldValue, newValue);
          } catch (e) {
            errorLog('call onData error: $e');
          }
        }

        super.value = newValue;
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    _onDataList.clear();
    super.dispose();
  }
}
