import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class TextFieldCustomPassword extends StatefulWidget {
  const TextFieldCustomPassword({
    required this.controller,
    required this.label,
    this.title,
    this.onChanged,
    this.onFocusChange,
    this.isLabelTitle = true,
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
  final bool isLabelTitle;
  final int? maxLength;

  @override
  State<TextFieldCustomPassword> createState() =>
      _TextFieldCustomPasswordState();
}

class _TextFieldCustomPasswordState extends State<TextFieldCustomPassword> {
  bool isPasswordVisible = true;
  OutlineInputBorder style() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.black12,
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
          if (widget.title != null) ...[
            Text(
              widget.title!,
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
            onFocusChange: (focus) => widget.onFocusChange?.call(focus: focus),
            child: TextFormField(
              maxLength: widget.maxLength,
              textAlignVertical: TextAlignVertical.center,
              obscureText: isPasswordVisible,
              keyboardType: widget.inputType,
              key: widget.controller.fieldKey,
              validator: widget.controller.validation,
              inputFormatters: widget.controller.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller.textEditingController,
              onChanged: widget.onChanged,
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
                hintText: widget.label,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 175, 175, 175),
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
                suffixIcon: GestureDetector(
                  child: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                  ),
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
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
