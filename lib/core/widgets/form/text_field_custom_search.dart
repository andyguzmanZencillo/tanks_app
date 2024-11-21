import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
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

  OutlineInputBorder style() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: FocusScope(
        onFocusChange: (focus) => onFocusChange?.call(focus: focus),
        child: TextFormField(
          maxLength: extendTextField?.maxLength,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: extendTextField?.inputType,
          key: controller?.fieldKey,
          validator: extendTextField?.validation,
          inputFormatters: extendTextField?.inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller?.textEditingController,
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
            prefixIcon: const Icon(
              Icons.search,
              color: Color.fromARGB(78, 0, 0, 0),
            ),
            fillColor: const Color.fromARGB(255, 230, 230, 230),
            hintText: extendTextField?.label,
            hintStyle: const TextStyle(
              color: Color.fromARGB(78, 0, 0, 0),
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
    );
  }
}
