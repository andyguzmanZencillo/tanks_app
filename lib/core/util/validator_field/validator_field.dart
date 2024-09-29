import 'dart:developer';

import 'package:tanks_app/core/util/validator_field/valid.dart';

class InputValidators {
  static bool isRequired(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isMinLength(String? value, int minLength) {
    return value != null && value.length >= minLength;
  }

  static bool isMaxLength(String? value, int maxLength) {
    return value != null && value.length <= maxLength;
  }

  static bool isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(value);
  }

  static bool isNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final numericRegex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');

    //final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(value);
  }

  static bool isZero(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final zeroRegex = RegExp(r'^0(\.0+)?$');

    return zeroRegex.hasMatch(value);
  }

  static bool isNegative(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final numericRegex = RegExp(r'^-\d*\.?\d+$');

    return numericRegex.hasMatch(value);
  }

  static bool isAlphabetic(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final alphabeticRegex = RegExp(r'^[a-zA-Z]+$');
    return alphabeticRegex.hasMatch(value);
  }

  static bool isDouble(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  static bool isAlphaNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphaNumericRegex.hasMatch(value);
  }
}

class Validator {
  static String? Function(String?, List<AbstractValid>) get validation {
    return (String? value, List<AbstractValid> validators) {
      log(value ?? 'NAN');
      for (final element in validators) {
        if (element.valid(value) != null) {
          return element.valid(value);
        }
      }
      return null;
      /*final invalidValidator = validators.firstWhereOrNull(
        (validator) => validator.valid(value) != null,
      );

      return invalidValidator?.valid(value);*/
    };
  }
}
