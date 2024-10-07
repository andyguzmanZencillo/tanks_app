import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';

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
    /* void actionPopUpItemSelected(
      String value,
      TanksEntity salesCenterEntity,
    ) {
      if (value == 'edit') {
        context
            .pushResult<bool?>(
          UpsertTanksPage.route(
            typeOperation: TypeOperation.update,
            consoleEntity: salesCenterEntity,
          ),
        )
            .then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<TanksCubit>().getAll();
        });
      } else if (value == 'delete') {
        showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DeleteTanksDialog(
              consoleEntity: salesCenterEntity,
            );
          },
        ).then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<TanksCubit>().getAll();
        });
      } else {}
    }*/

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.art_track,
            color: Colors.white,
          ),
        ),
        title: Text(tanksEntity.codigo.toString()),
        subtitle: Text(
          tanksEntity.descripcion,
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
