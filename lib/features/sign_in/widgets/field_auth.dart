import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';

class FieldAuth extends StatelessWidget {
  const FieldAuth({
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.label,
    required this.icon,
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
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 218, 218, 218),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
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
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Ingresa tu ${label.toLowerCase()}',
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
class ControllerField {
  final _textEditingController = TextEditingController();
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  GlobalKey<FormFieldState<String>> get fieldKey => _fieldKey;
  FocusNode get focuNode => _focusNode;
  TextEditingController get textEditingController => _textEditingController;
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
}
*/
class FieldAuth2 extends StatefulWidget {
  const FieldAuth2({
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.label,
    required this.icon,
    this.onFocusChange,
    this.isLoading = false,
    this.isLabelTitle = false,
    this.showDecoration = true,
    this.isActiveValidation = true,
    this.showError = false,
    this.isPassword = false,
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
  final bool isPassword;
  final Icon icon;

  @override
  State<FieldAuth2> createState() => _FieldAuth2State();
}

class _FieldAuth2State extends State<FieldAuth2> {
  var _isPassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 235, 236),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FocusScope(
            onFocusChange: (s) => widget.onFocusChange,
            child: TextFormField(
              obscureText: _isPassword,
              keyboardType: widget.inputType,
              key: widget.controller.fieldKey,
              validator: widget.isActiveValidation ? widget.validator : null,
              inputFormatters: widget.inputFormatters,
              readOnly: widget.isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller.textEditingController,
              onChanged: widget.onChanged,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                /*icon: Icon(
                  icon.icon,
                  color: const Color.fromARGB(255, 65, 65, 65),
                ),*/
                hintText: 'Ingresa tu ${widget.label.toLowerCase()}',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 117, 117, 117),
                  fontWeight: FontWeight.w400,
                ),
                errorStyle: !widget.showError
                    ? const TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      )
                    : null,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        child: _isPassword
                            ? const Icon(Icons.read_more)
                            : const Icon(Icons.remove_red_eye),
                        onTap: () {
                          setState(() {
                            _isPassword = !_isPassword;
                          });
                        },
                      )
                    : null,
                focusedErrorBorder: !widget.showError ? InputBorder.none : null,
                errorBorder: !widget.showError ? InputBorder.none : null,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
