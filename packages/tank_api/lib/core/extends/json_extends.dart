extension JsonExtension on Map<String, dynamic> {
  T get<T>(String key, T defaultValue) {
    if (T == DateTime) {
      // Si el valor es una cadena y el tipo esperado es DateTime
      return this[key] != null
          ? DateTime.parse(this[key] as String) as T
          : defaultValue;
    }
    return this[key] is T ? this[key] as T : defaultValue;
  }
}
