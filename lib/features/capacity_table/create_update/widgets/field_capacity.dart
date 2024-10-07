import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';

class FieldCapacity extends StatelessWidget {
  const FieldCapacity({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.isInteger = false,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final bool isInteger;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: [
        if (isInteger)
          FilteringTextInputFormatter.digitsOnly
        else
          DecimalTextInputFormatter(decimalRange: 3),
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    );
  }
}
