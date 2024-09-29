import 'package:tanks_app/core/util/validator_field/validator_field.dart';

abstract class AbstractValid {
  String? valid(String? value);
}

class AlphaNumericValid extends AbstractValid {
  AlphaNumericValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (!InputValidators.isAlphaNumeric(value)) {
      return error ?? 'El campo contiene valores invalidos';
    }

    return null;
  }
}

class RequiredValid extends AbstractValid {
  RequiredValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (!InputValidators.isRequired(value)) {
      return error ?? 'Campo necesario';
    }

    return null;
  }
}

class RequiredNumericValid extends AbstractValid {
  RequiredNumericValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (!InputValidators.isRequired(value)) {
      return error ?? 'Campo necesario';
    }

    return null;
  }
}

class NumericValid extends AbstractValid {
  NumericValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (!InputValidators.isNumeric(value)) {
      return error ?? 'El Valor no es numerico';
    }

    return null;
  }
}

class ZeroValid extends AbstractValid {
  ZeroValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (InputValidators.isZero(value)) {
      return error ?? 'El Valor no es numerico';
    }

    return null;
  }
}

class NegativeValid extends AbstractValid {
  NegativeValid({this.error});

  final String? error;

  @override
  String? valid(String? value) {
    if (InputValidators.isNegative(value)) {
      return error ?? 'El Valor es negativo';
    }

    return null;
  }
}
