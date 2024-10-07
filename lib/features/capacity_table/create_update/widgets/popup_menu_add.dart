import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/dialog_csv.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/dialog_secuence.dart';

class PopupMenuAdd extends StatelessWidget {
  const PopupMenuAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 170, 25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton(
        icon: const Icon(Icons.add),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'new',
              onTap: upsertCapacityCubit.addStagingItem,
              child: const Text('Nuevo'),
            ),
            PopupMenuItem(
              value: 'secuence',
              onTap: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: upsertCapacityCubit,
                      child: const DialogSecuence(),
                    );
                  },
                );
              },
              child: const Text('Añadir por escala'),
            ),
            PopupMenuItem(
              value: 'csv',
              onTap: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: upsertCapacityCubit,
                      child: const DialogCSV(),
                    );
                  },
                );
              },
              child: const Text('Importar CSV'),
            ),
          ];
        },
      ),
    );
  }
}
