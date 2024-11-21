import 'package:flutter/material.dart';

class ViewIconStatus extends StatelessWidget {
  const ViewIconStatus({
    required this.text,
    required this.icon,
    super.key,
  });
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon.icon,
            color: Colors.grey.shade400,
            size: 130,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
