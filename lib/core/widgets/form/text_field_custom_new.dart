import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/form/validator_field/validator_field.dart';

class TextFieldCustomNew extends StatelessWidget {
  const TextFieldCustomNew({
    required this.controller,
    required this.label,
    this.title,
    this.onChanged,
    this.onFocusChange,
    this.inputType,
    this.maxLength,
    super.key,
  });
  final ControllerField controller;
  final void Function(String)? onChanged;
  final void Function({required bool focus})? onFocusChange;
  final TextInputType? inputType;
  final String label;
  final String? title;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder style() {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: Colors.black12,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                color: Color.fromARGB(255, 85, 90, 90),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          FocusScope(
            onFocusChange: (focus) => onFocusChange?.call(focus: focus),
            child: TextFormField(
              maxLength: maxLength,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: inputType,
              key: controller.fieldKey,
              validator: controller.validation,
              inputFormatters: controller.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.textEditingController,
              onChanged: onChanged,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                hintText: label,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 175, 175, 175),
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
                enabledBorder: style(),
                focusedBorder: style(),
                errorBorder: style(),
                focusedErrorBorder: style(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldPro extends StatefulWidget {
  const TextFieldPro({
    this.controller,
    this.extendTextField,
    this.onChanged,
    this.onFocusChange,
    super.key,
  });
  final ControllerFieldPro? controller;
  final ExtendTextField? extendTextField;

  final void Function(String)? onChanged;
  final void Function({required bool focus})? onFocusChange;

  @override
  State<TextFieldPro> createState() => _TextFieldProState();
}

class _TextFieldProState extends State<TextFieldPro> {
  bool? validIcon;
  void _validate(String? value) {
    final result = widget.extendTextField?.validation.call(value);
    final shouldBeValid = result == null;

    if (validIcon != shouldBeValid) {
      setState(() {
        validIcon = shouldBeValid;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller?.textEditingController != null) {
      _validate(widget.controller?.getValue());
    }
  }

  Icon? iconFix() {
    if (validIcon == null) return null;
    if (validIcon! == true) {
      return const Icon(Icons.check);
    } else if (validIcon == false) {
      return null;
      //return const Icon(Icons.info, color: Colors.red);
    }
    return null;
  }

  OutlineInputBorder style() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Color.fromARGB(78, 0, 0, 0),
        width: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.extendTextField != null &&
              widget.extendTextField!.title != null) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.extendTextField!.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.extendTextField != null &&
                      widget.extendTextField!.isRequired)
                    const TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          /*if (widget.extendTextField != null &&
              widget.extendTextField!.title != null) ...[
            Text(
              widget.extendTextField!.title!,
              style: const TextStyle(
                color: Color.fromARGB(255, 48, 49, 49),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],*/
          FocusScope(
            onFocusChange: (focus) => widget.onFocusChange?.call(focus: focus),
            child: TextFormField(
              maxLength: widget.extendTextField?.maxLength,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.extendTextField?.inputType,
              key: widget.controller?.fieldKey,
              validator: widget.extendTextField?.validation,
              inputFormatters: widget.extendTextField?.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller?.textEditingController,
              onChanged: (v) => {
                widget.onChanged?.call(v),
                _validate(v),
              },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                counterText: '',
                suffixIcon: iconFix(),
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                hintText: widget.extendTextField?.label,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 141, 141, 141),
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                enabledBorder: style(),
                focusedBorder: style(),
                errorBorder: style(),
                focusedErrorBorder: style(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExtendTextField {
  ExtendTextField({
    this.inputFormatters,
    this.validators,
    this.inputType,
    this.label,
    this.title,
    this.maxLength,
    this.isRequired = true,
  });

  final List<TextInputFormatter>? inputFormatters;
  final List<AbstractValid>? validators;
  final bool isRequired;
  final TextInputType? inputType;

  final String? label;
  final String? title;
  final int? maxLength;

  String? Function(String?) get validation => (String? value) {
        return Validator.validation(
          value,
          validators ?? <AbstractValid>[],
        );
      };
}

class SufixPassword extends StatefulWidget {
  const SufixPassword({
    super.key,
  });

  @override
  State<SufixPassword> createState() => _SufixPasswordState();
}

class _SufixPasswordState extends State<SufixPassword> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isVisible ? Icons.visibility_off : Icons.remove_red_eye,
      ),
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
    );
  }
}

class SufixState extends StatefulWidget {
  const SufixState({
    super.key,
  });

  @override
  State<SufixState> createState() => _SufixStateState();
}

class _SufixStateState extends State<SufixState> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        isVisible ? Icons.visibility_off : Icons.remove_red_eye,
      ),
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
    );
  }
}
