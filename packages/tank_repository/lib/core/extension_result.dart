import 'package:oxidized/oxidized.dart';

extension ExtensionString on String {
  String validEmpty(String value) {
    if (trim().isEmpty) {
      return value;
    }
    return this;
  }
}

extension GetData<T extends Object, E extends Object> on Result<T, E> {
  T data() {
    return matchOk((p0) => p0)!;
  }

  E error() {
    return matchErr((p0) => p0)!;
  }

  Result<S, E> fail<S>() {
    return Result.err(matchErr((p0) => p0)!);
  }
}
