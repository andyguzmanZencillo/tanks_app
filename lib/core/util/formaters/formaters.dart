import 'package:flutter/services.dart';

/*class NoSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.trim();
    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
*/
class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.replaceAll(' ', '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}

class RemoveSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Reemplaza los espacios en blanco sin afectar la posición del cursor
    final newText = newValue.text.replaceAll(' ', '');
    final cursorPosition =
        newValue.selection.baseOffset - (newValue.text.length - newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange});
  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    }
    final newText = newValue.text;
    if (newText.contains('.') &&
        newText.substring(newText.indexOf('.') + 1).length > decimalRange) {
      return oldValue;
    }
    return newValue;
  }
}

class AlphanumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.replaceAll(RegExp('[^a-zA-Z0-9]'), '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}

/*
class AlphanumericWithSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.replaceAll(RegExp('[^a-zA-Z0-9 ]'), '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}
*/
class AlphanumericWithSpaceNoLeadingInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text
        .replaceAll(RegExp('[^a-zA-Z0-9 ]'), '')
        .replaceFirst(RegExp(r'^\s+'), '');

    final cursorPosition = newValue.selection.baseOffset -
        (newValue.text.length - filteredText.length);

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

/// Formatea el texto para permitir solo letras, números y espacios
class AlphanumericWithSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.replaceAll(RegExp('[^a-zA-Z0-9 ]'), '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}

/// Formatea el texto para eliminar los espacios al inicio
class NoLeadingSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.replaceFirst(RegExp(r'^\s+'), '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}

class NoOnlyZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Permitir el campo vacío o valores distintos a solo "0" o "0.0"
    if (text == '0' || text == '0.0') {
      return oldValue;
    }

    return newValue;
  }
}

class IpAddressInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Expresión regular para validar una dirección IP mientras el usuario escribe
    final ipRegex = RegExp(r'^(?:\d{1,3}\.){0,3}\d{0,3}$');

    // Verificar si el texto coincide con el formato de una IP parcial
    if (ipRegex.hasMatch(newValue.text)) {
      // Asegurarse de que cada número en la IP esté en el rango de 0 a 255
      final segments = newValue.text.split('.');
      for (final segment in segments) {
        if (segment.isNotEmpty && int.parse(segment) > 255) {
          return oldValue; // Regresa al valor anterior si algún segmento es mayor que 255
        }
      }
      return newValue;
    } else {
      // Si el nuevo valor no coincide con el patrón, volver al valor anterior
      return oldValue;
    }
  }
}

class TrailingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Elimina los espacios finales del texto, pero respeta la posición del cursor
    final trimmedText = newValue.text.trimRight();
    final cursorPosition = newValue.selection.baseOffset;

    // Ajusta la posición del cursor si estaba al final
    final newCursorPosition = cursorPosition > trimmedText.length
        ? trimmedText.length
        : cursorPosition;

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}
