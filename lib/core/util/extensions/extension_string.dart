extension StringToDoubleExtension on String? {
  double toDoubleSafe() {
    // Si es nulo o vacío, devuelve 0
    if (this == null || this!.trim().isEmpty) {
      return 0;
    }

    // Expresión regular para validar si la cadena es un número
    final regex = RegExp(r'^-?\d+(\.\d+)?$');

    // Verifica si la cadena coincide con el patrón y devuelve el double o 0
    if (regex.hasMatch(this!.trim())) {
      return double.parse(this!.trim());
    } else {
      return 0;
    }
  }
}

extension StringToIntExtension on String? {
  int toIntSafe() {
    // Si es nulo o vacío, devuelve 0
    if (this == null || this!.trim().isEmpty) {
      return 0;
    }

    // Expresión regular para validar si la cadena es un número entero
    final regex = RegExp(r'^-?\d+$');

    // Verifica si la cadena coincide con el patrón y devuelve el int o 0
    if (regex.hasMatch(this!.trim())) {
      return int.parse(this!.trim());
    } else {
      return 0;
    }
  }
}
