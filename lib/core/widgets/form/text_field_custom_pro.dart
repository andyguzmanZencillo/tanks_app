import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class TextFieldCustomPro extends StatefulWidget {
  const TextFieldCustomPro({
    required this.controller,
    required this.label,
    this.onChanged,
    this.onFocusChange,
    this.isPassword = false,
    this.isLabelTitle = true,
    this.inputType,
    super.key,
  });
  final ControllerField controller;
  final void Function(String)? onChanged;
  final void Function({required bool focus})? onFocusChange;
  final TextInputType? inputType;
  final String label;
  final bool isPassword;
  final bool isLabelTitle;

  @override
  State<TextFieldCustomPro> createState() => _TextFieldCustomProState();
}

class _TextFieldCustomProState extends State<TextFieldCustomPro> {
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPassword;
  }

  Widget? _suffixIcon() {
    if (widget.isPassword) {
      return GestureDetector(
        child: Icon(
          _isPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
        ),
        onTap: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelTitle) ...[
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
          ],
          FocusScope(
            onFocusChange: (focus) {
              if (widget.onFocusChange == null) return;
              widget.onFocusChange!(focus: focus);
            },
            child: Stack(
              children: [
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 16,
                        color: Colors.black12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: _isPasswordVisible,
                  keyboardType: widget.inputType,
                  key: widget.controller.fieldKey,
                  validator: widget.controller.validation,
                  inputFormatters: widget.controller.inputFormatters,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: widget.controller.textEditingController,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: widget.label,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117),
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: _suffixIcon(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
