import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';

class UpsertCapacityTableListener {
  static BlocListener<UpsertCapacityTableCubit, UpsertCapacityTableState>
      upsertTankVariation() {
    return BlocListener<UpsertCapacityTableCubit, UpsertCapacityTableState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Guardando tabla de aforo',
              );
            },
          );
        } else if (s == UpsertStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message:
                      state.errorMessage ?? 'Error al guardar tabla de aforo',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (s == UpsertStatus.success) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.good(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: 'Taba de aforo guardado exitosamente',
                  title: 'Guardado exitoso',
                  onPressed: () {
                    context.pop();
                    Navigator.pop(context, true);
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        }
      },
    );
  }
}
