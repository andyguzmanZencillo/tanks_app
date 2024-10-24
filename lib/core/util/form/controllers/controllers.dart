import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/form/validator_field/validator_field.dart';

class ControllerFieldDatePicker {
  DateTime date = DateTime.now();

  final fieldKey = GlobalKey<FormFieldState<DateTime>>();
  final FocusNode focusNode = FocusNode();

  // ignore: use_setters_to_change_properties
  void setValue(DateTime value) {
    date = value;
  }

  DateTime getValue() {
    return date;
  }
}

class ControllerField {
  ControllerField({
    this.validators,
    this.inputFormatters,
  });
  final _textEditingController = TextEditingController();
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();
  final List<AbstractValid>? validators;
  final List<TextInputFormatter>? inputFormatters;

  GlobalKey<FormFieldState<String>> get fieldKey => _fieldKey;
  FocusNode get focuNode => _focusNode;
  TextEditingController get textEditingController => _textEditingController;

  // ignore: use_setters_to_change_properties
  void setValue(String value) {
    log('value => $value');
    _textEditingController.text = value;
  }

  String getValue() {
    return _textEditingController.text;
  }

  String? Function(String?) get validation => (String? value) {
        return Validator.validation(
          value,
          validators ?? <AbstractValid>[],
        );
      };

  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
  }
}

class ControllerFieldDropdown<T> {
  ValueExtend<T> _value = ValueExtend<T>();
  final _fieldKey = GlobalKey<FormFieldState<ValueExtend<T>>>();
  final _focusNode = FocusNode();

  GlobalKey<FormFieldState<ValueExtend<T>>> get fieldKey => _fieldKey;
  FocusNode get focusNode => _focusNode;
  ValueExtend<T> get value => _value;
  int get id => _value.id;

  void setValue(ValueExtend<T> value) {
    log('value => $value');
    _value = value;
  }

  ValueExtend<T> getValue() {
    return _value;
  }

  void dispose() {
    _focusNode.dispose();
  }
}

extension CustomFormValidator on GlobalKey<FormState> {
  ResultValidate validateAndGetErrors(
    List<GlobalKey<FormFieldState<dynamic>>> fieldKeys,
  ) {
    final formState = currentState;
    final errors = <String, String?>{};

    if (formState != null) {
      var isValid = true;

      for (final key in fieldKeys) {
        final fieldState = key.currentState;

        if (fieldState != null) {
          fieldState.validate();

          if (fieldState.hasError) {
            errors[key.toString()] = fieldState.errorText;
            isValid = false;
          }
        }
      }

      return ResultValidate(errors: isValid ? {} : errors, isPassed: isValid);
    }

    return ResultValidate(errors: {}, isPassed: false);
  }
}

class ResultValidate {
  ResultValidate({required this.errors, required this.isPassed});
  final Map<String, String?> errors;
  final bool isPassed;

  List<String> getErrors() {
    return errors.values.whereNotNull().toList();
  }

  bool existErr() {
    return errors.values.isEmpty;
  }
}
