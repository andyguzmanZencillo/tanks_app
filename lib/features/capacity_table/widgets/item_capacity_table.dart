import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/capacity_table/create_update/views/upsert_capacity_table_page.dart';
import 'package:tanks_app/features/capacity_table/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';

class ItemCapacityTable extends StatelessWidget {
  const ItemCapacityTable({required this.tanksEntity, super.key});
  final CapacityTableEntity tanksEntity;

  @override
  Widget build(BuildContext context) {
    void actionPopUpItemSelected(
      String value,
      CapacityTableEntity salesCenterEntity,
    ) {
      if (value == 'edit') {
        context
            .pushResult<bool?>(
          UpsertCapacityTablePage.route(
            typeOperation: TypeOperation.update,
            consoleEntity: salesCenterEntity,
          ),
        )
            .then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<CapacityTableCubit>().getAll();
        });
      } else if (value == 'delete') {
        showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DeleteCapacityTableDialog(
              consoleEntity: salesCenterEntity,
            );
          },
        ).then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<CapacityTableCubit>().getAll();
        });
      } else {}
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.art_track,
            color: Colors.white,
          ),
        ),
        title: Text(tanksEntity.alturaTanque.toString()),
        subtitle: Text(
          tanksEntity.volumen.toString(),
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
