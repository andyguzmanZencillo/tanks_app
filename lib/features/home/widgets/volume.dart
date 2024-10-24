import 'package:flutter/material.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class VolumeWidget extends StatelessWidget {
  const VolumeWidget({
    required this.volumenGal,
    required this.volumenMax,
    super.key,
  });
  final double volumenGal;
  final double volumenMax;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: BlueStoneColors.blueStone700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10), // Uniform radius
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Volumen(Gal)',
                    style: TextStyle(
                      fontSize: 16,
                      color: BlueStoneColors.blueStone700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                volumenGal.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: BlueStoneColors.blueStone700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10), // Uniform radius
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Volumen Max +',
                    style: TextStyle(
                      fontSize: 16,
                      color: BlueStoneColors.blueStone700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                volumenMax.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
