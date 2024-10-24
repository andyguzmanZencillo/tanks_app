import 'package:flutter/material.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ItemConfig extends StatelessWidget {
  const ItemConfig({
    required this.configEntity,
    required this.onTapEdit,
    required this.onTapDelete,
    super.key,
  });
  final ConfigEntity configEntity;
  final void Function() onTapEdit;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlueStoneColors.blueStone200,
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: BlueStoneColors.blueStone600,
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        title: Text(
          'N°: ${configEntity.idConfiguracion}',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: BlueStoneColors.blueStone950,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                onTap: onTapEdit,
                child: const Text('Editar'),
              ),
              PopupMenuItem(
                value: 'delete',
                onTap: onTapDelete,
                child: const Text('Eliminar'),
              ),
            ];
          },
          //onSelected: (v) => actionPopUpItemSelected(v, consoleEntity),
        ),
      ),
    );
  }
}
