import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldCustom extends StatelessWidget {
  const FieldCustom({
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.label,
    this.onFocusChange,
    this.isLoading = false,
    this.isLabelTitle = false,
    this.showDecoration = true,
    this.isActiveValidation = true,
    this.showError = false,
    this.inputFormatters,
    this.inputType,
    super.key,
  });
  final ControllerField controller;
  final String? Function(String?) validator;
  final void Function(String) onChanged;
  final void Function({required bool focus})? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final bool isLoading;
  final String label;
  final bool isLabelTitle;
  final bool showDecoration;
  final bool showError;
  final bool isActiveValidation;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLabelTitle) ...[
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
        ],
        Container(
          height: 55,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 10),
          decoration: showDecoration
              ? BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          child: FocusScope(
            onFocusChange: (s) => onFocusChange,
            child: TextFormField(
              keyboardType: inputType,
              key: controller.fieldKey,
              validator: isActiveValidation ? validator : null,
              inputFormatters: inputFormatters,
              readOnly: isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.textEditingController,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
                errorStyle: !showError
                    ? const TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      )
                    : null,
                focusedErrorBorder: !showError ? InputBorder.none : null,
                errorBorder: !showError ? InputBorder.none : null,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: isLoading
                    ? Container(
                        width: 10,
                        height: 10,
                        padding: const EdgeInsets.all(18),
                        child: const CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ControllerField {
  final _textEditingController = TextEditingController();
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  GlobalKey<FormFieldState<String>> get fieldKey => _fieldKey;
  FocusNode get focuNode => _focusNode;
  TextEditingController get textEditingController => _textEditingController;

  void dispose() {
    _textEditingController.dispose();
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
