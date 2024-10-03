import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_page.dart';
import 'package:tanks_app/features/tanks/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/tanks/detail/detail_tank.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

class ItemTank extends StatelessWidget {
  const ItemTank({required this.tanksEntity, super.key});
  final TanksEntity tanksEntity;

  @override
  Widget build(BuildContext context) {
    void actionPopUpItemSelected(
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
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          context.pushResult<bool?>(
            DetailTankView.route(tanksEntity: tanksEntity),
          );
        },
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
              const PopupMenuItem(
                value: 'edit',
                child: Text('Editar'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar'),
              ),
            ];
          },
          onSelected: (v) => actionPopUpItemSelected(v, tanksEntity),
        ),
      ),
    );
  }
}
