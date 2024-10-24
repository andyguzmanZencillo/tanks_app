import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class GallonsWidget extends StatelessWidget {
  const GallonsWidget({required this.speed, required this.maxSpeed, super.key});
  final double speed;
  final double maxSpeed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: KdGaugeView(
        minSpeed: 0,
        maxSpeed: maxSpeed,
        speed: speed,
        speedTextStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        subDivisionCircleColors: Colors.transparent,
        divisionCircleColors: Colors.transparent,
        minMaxTextStyle: const TextStyle(
          fontSize: 0,
        ),
        innerCirclePadding: 0,
        unitOfMeasurementTextStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        unitOfMeasurement: 'Galones',
        alertSpeedArray: const [0],
        gaugeWidth: 20,
        alertColorArray: const [
          BlueStoneColors.blueStone700,
        ],
        duration: const Duration(seconds: 6),
      ),
    );
  }
}
