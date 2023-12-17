extension ExString on String? {
  String get withColon {
    return '$this:';
  }

  bool get isNullOrBlank {
    return this == null || this!.trim().isEmpty;
  }
}
