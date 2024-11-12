import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/constans/assets.dart';

class InfoGeneral extends StatelessWidget {
  const InfoGeneral({required this.userEntity, super.key});
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(5),
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: BlueStoneColors.blueStone600,
                ),
              ),
            ],
          ),
          Align(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    height: 120,
                    Assets.logo,
                  ),
                ),
                Text(
                  userEntity.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    'Zencillo Tanques permite la gestión eficiente de capacidades, estados y detalles técnicos de tanques',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: BlueStoneColors.blueStone700,
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
