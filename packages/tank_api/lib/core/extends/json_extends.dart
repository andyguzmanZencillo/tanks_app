extension JsonExtension on Map<String, dynamic> {
  T get<T>(String key, T defaultValue) {
    if (T == DateTime) {
      return this[key] != null
          ? DateTime.parse(this[key] as String) as T
          : defaultValue;
    }
    return this[key] is T ? this[key] as T : defaultValue;
  }
}

extension JsonExtensionPro on Map<String, dynamic> {
  T getPro<T>(String key, T defaultValue) {
    final value = this[key];

    if (value == null) return defaultValue;

    if (T == DateTime) {
      return DateTime.parse(value as String) as T;
    }

    if (T == String) {
      return value.toString() as T;
    }

    if (T == int) {
      return int.tryParse(value.toString()) as T? ?? defaultValue;
    }

    if (T == double) {
      return double.tryParse(value.toString()) as T? ?? defaultValue;
    }

    return value is T ? value : defaultValue;
  }
}
