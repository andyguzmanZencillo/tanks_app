import 'package:flutter/material.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class CustomElevateButton extends StatelessWidget {
  const CustomElevateButton({
    required this.onPressed,
    required this.text,
    this.isFlexible = false,
    this.icon,
    super.key,
  });
  final void Function() onPressed;
  final String text;
  final bool isFlexible;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isFlexible ? null : 50,
      width: isFlexible ? null : double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BlueStoneColors.blueStone700,
          padding: const EdgeInsets.symmetric(
            //vertical: 15,
            horizontal: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            if (icon != null) ...[
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
