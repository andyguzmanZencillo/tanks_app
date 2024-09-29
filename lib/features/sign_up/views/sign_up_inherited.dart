import 'package:flutter/material.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';

class SignUpInherited extends InheritedWidget {
  SignUpInherited({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final idCompany = ControllerField();
  final user = ControllerField();
  final name = ControllerField();
  final password = ControllerField();

  final formKey = GlobalKey<FormState>();

  static SignUpInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SignUpInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  void dispose() {
    idCompany.dispose();
    user.dispose();
    name.dispose();
    password.dispose();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      idCompany.fieldKey,
      user.fieldKey,
      name.fieldKey,
      password.fieldKey,
    ]);
  }
}
