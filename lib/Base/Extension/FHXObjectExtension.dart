extension FHXObjectExtension on Object? {
  /// 判断对象是否为空
  bool get isNull {
    final value = this;
    if (value == null) return true;

    if (value is String) {
      final str = value.trim();
      return str.isEmpty ||
          str.toLowerCase() == 'null' ||
          str == '(null)' ||
          str == '<null>';
    }

    if (value is Iterable) {
      return value.isEmpty;
    }

    if (value is Map) {
      return value.isEmpty;
    }

    return false;
  }
}

