import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';

class FieldVariationTank extends StatelessWidget {
  const FieldVariationTank({
    required this.controller,
    required this.label,
    this.onFocusChange,
    this.enable = true,
    super.key,
  });
  final ControllerField controller;
  final String label;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool, String)? onFocusChange;

  final bool enable;

  @override
  Widget build(BuildContext context) {
    return FieldVariation(
      icon: const Icon(Icons.money),
      labelSingle: false,
      onFocusChange: onFocusChange,
      enable: enable,
      inputFormatters: [
        //FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(decimalRange: 3),
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      controller: controller,
      validator: (value) => Validator.validation(
        value,
        [
          RequiredValid(
            error: 'Campo $label requerido',
          ),
        ],
      ),
      label: label,
    );
  }
}
