import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ItemTank extends StatelessWidget {
  const ItemTank({
    required this.tanksEntity,
    required this.onTap,
    required this.onTapEdit,
    required this.onTapDelete,
    super.key,
  });
  final TanksEntity tanksEntity;
  final void Function() onTap;
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
        onTap: onTap,
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: BlueStoneColors.blueStone600,
          child: Icon(
            Icons.oil_barrel,
            color: Colors.white,
          ),
        ),
        title: Text(
          tanksEntity.descripcion,
          style: const TextStyle(
            color: BlueStoneColors.blueStone950,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Capacidad: ${tanksEntity.capacidad}',
              style: const TextStyle(
                color: BlueStoneColors.blueStone900,
              ),
            ),
            Text(
              'Altura Tanque: ${tanksEntity.alturaTanque}',
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
          //onSelected: (v) => actionPopUpItemSelected(v, tanksEntity),
        ),
      ),
    );
  }
}
