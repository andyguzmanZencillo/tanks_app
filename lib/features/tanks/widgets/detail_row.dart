import 'package:flutter/material.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class DetailRow extends StatelessWidget {
  const DetailRow(
    this.label,
    this.value,
    this.icon, {
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: BlueStoneColors.blueStone900,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: BlueStoneColors.blueStone600,
            ),
          ),
        ],
      ),
    );
  }
}
