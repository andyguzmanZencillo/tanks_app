import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';

class SignInInherited extends InheritedWidget {
  SignInInherited({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final idCompany = ControllerField(
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      NoSpaceFormatter(),
    ],
    validators: [
      RequiredValid(
        error: 'Campo del ID compañia requerido...',
      ),
    ],
  );
  final user = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
    inputFormatters: [
      NoSpaceFormatter(),
      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z@.]')),
    ],
  );

  final password = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
    inputFormatters: [
      NoSpaceFormatter(),
    ],
  );

  final formKey = GlobalKey<FormState>();

  static SignInInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<SignInInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      idCompany.fieldKey,
      user.fieldKey,
      password.fieldKey,
    ]);
  }
}
