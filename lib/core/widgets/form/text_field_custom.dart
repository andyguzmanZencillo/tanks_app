import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
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
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
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
            if (widget.onFocusChange == null) return;
            widget.onFocusChange!(focus: focus);
          },
          child: SizedBox(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              // ignore: avoid_bool_literals_in_conditional_expressions
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
