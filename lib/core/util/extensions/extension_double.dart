extension SafeDouble on double? {
  double orZero({double alternative = 0.0}) {
    if (this == null || this!.isNaN || this!.isInfinite) {
      return alternative;
    }
    return this!;
  }
}

extension SafeDoubleToString on double? {
  String toSafeString() {
    if (this == null || this == 0.0) {
      return '';
    }
    return this!.toString();
  }
}

extension SafeIntToString on int? {
  String toSafeString() {
    if (this == null || this == 0) {
      return '';
    }
    return this!.toString();
  }
}

extension NullableDoubleExtensions on String? {
  bool isNullOrZero() {
    return this == null || this == '0.0' || this == '';
  }
}
