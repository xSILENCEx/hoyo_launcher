import 'dart:io';

import 'package:flutter/foundation.dart';

String get appDirectoryPath {
  if (kDebugMode) {
    return '${Directory.current.path}\\build\\windows\\runner\\Debug';
  } else {
    return Directory.current.path;
  }
}
