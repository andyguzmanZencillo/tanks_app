import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class PercentageExistence extends StatelessWidget {
  const PercentageExistence({required this.percentage, super.key});
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          LinearPercentIndicator(
            width: 200,
            barRadius: const Radius.circular(10),
            lineHeight: 12,
            alignment: MainAxisAlignment.center,
            percent: percentage / 100,
            backgroundColor: BlueStoneColors.blueStone200,
            progressColor: BlueStoneColors.blueStone700,
          ),
        ],
      ),
    );
  }
}
