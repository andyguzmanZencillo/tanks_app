import 'package:flutter/material.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    super.key,
  });
  final void Function() onPressed;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? BlueStoneColors.blueStone700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
