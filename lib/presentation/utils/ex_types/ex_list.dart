extension ExList<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test, {T Function()? orElse}) {
    try {
      return firstWhere(test, orElse: orElse);
    } catch (_) {
      return null;
    }
  }

  bool sameWith(List<T> other) {
    if (length != other.length) return false;

    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }

    return true;
  }
}
