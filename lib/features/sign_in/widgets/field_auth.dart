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
    required this.label,
    required this.icon,
    this.onChanged,
    this.onFocusChange,
    this.isLabelTitle = false,
    this.showDecoration = true,
    this.isPassword = false,
    this.inputFormatters,
    this.inputType,
    this.labelSingle = true,
    super.key,
  });
  final ControllerField controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final void Function({required bool focus})? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;

  final String label;
  final bool isLabelTitle;
  final bool showDecoration;

  final bool isPassword;
  final Icon icon;

  final bool labelSingle;

  @override
  State<FieldAuth2> createState() => _FieldAuth2State();
}

class _FieldAuth2State extends State<FieldAuth2> {
  bool _isPasswordVisible = false; // Mejoramos el nombre de la variable

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
        FocusScope(
          onFocusChange: (focus) {
            // Corregimos la invocación del onFocusChange
            if (widget.onFocusChange != null) {
              widget.onFocusChange!(focus: focus);
            }
          },
          child: SizedBox(
            //height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: widget.isPassword
                  ? !_isPasswordVisible
                  : false, // Control de visibilidad de la contraseña
              keyboardType: widget.inputType,
              key: widget.controller.fieldKey,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,

              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller.textEditingController,
              onChanged: widget.onChanged,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 233, 235, 236),
                hintText: widget.labelSingle
                    ? 'Ingresa tu ${widget.label.toLowerCase()}'
                    : widget.label,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 117, 117, 117),
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.remove_red_eye
                              : Icons
                                  .visibility_off, // Cambia el ícono según el estado
                        ),
                        onTap: () {
                          setState(() {
                            _isPasswordVisible =
                                !_isPasswordVisible; // Cambia el estado de visibilidad
                          });
                        },
                      )
                    : null,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FieldTextCustom extends StatefulWidget {
  const FieldTextCustom({
    required this.controller,
    required this.validator,
    required this.label,
    required this.icon,
    this.onChanged,
    this.onFocusChange,
    this.isLabelTitle = false,
    this.showDecoration = true,
    this.isPassword = false,
    this.inputFormatters,
    this.inputType,
    this.labelSingle = true,
    super.key,
  });
  final ControllerField controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool focus)? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;

  final String label;
  final bool isLabelTitle;
  final bool showDecoration;

  final bool isPassword;
  final Icon icon;

  final bool labelSingle;

  @override
  State<FieldTextCustom> createState() => _FieldTextCustomState();
}

class _FieldTextCustomState extends State<FieldTextCustom> {
  bool _isPasswordVisible = false;

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
        FocusScope(
          onFocusChange: widget.onFocusChange,
          child: SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: widget.isPassword ? !_isPasswordVisible : false,
              keyboardType: widget.inputType,
              key: widget.controller.fieldKey,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller.textEditingController,
              onChanged: widget.onChanged,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: const Color.fromARGB(255, 233, 235, 236),
                hintText: widget.labelSingle
                    ? 'Ingresa tu ${widget.label.toLowerCase()}'
                    : widget.label,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 117, 117, 117),
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : null,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
