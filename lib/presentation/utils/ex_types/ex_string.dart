extension ExString on String? {
  String get withColon {
    return '$this:';
  }

  bool get isNullOrEmpty {
    return this == null || this!.trim().isEmpty;
  }
}
