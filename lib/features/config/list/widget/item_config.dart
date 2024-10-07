import 'package:flutter/material.dart';
import 'package:tank_repository/features/config/entity/config_entity.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        title: Text('N°: ${configEntity.idConfiguracion}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hora incio Zeta: ${configEntity.horaInicioZeta}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Hora fin Zeta: ${configEntity.horaFinZeta}',
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
