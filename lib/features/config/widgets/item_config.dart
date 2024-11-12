import 'package:flutter/material.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';

class ItemConfig extends StatelessWidget {
  const ItemConfig({
    required this.configEntity,
    required this.onTapEdit,
    super.key,
  });
  final ConfigEntity configEntity;
  final void Function() onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlueStoneColors.blueStone200,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hora incio Zeta: ${configEntity.horaInicioZeta}',
            style: const TextStyle(
              color: BlueStoneColors.blueStone900,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Hora fin Zeta: ${configEntity.horaFinZeta}',
            style: const TextStyle(
              color: BlueStoneColors.blueStone900,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GenericButton(onPressed: onTapEdit, icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
