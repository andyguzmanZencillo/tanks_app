import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';

class DialogListener {
  static BlocListener<UpsertTanksCubit, UpsertTanksState> upsertTank() {
    return BlocListener<UpsertTanksCubit, UpsertTanksState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        /*final dialog = context.read<DialogHandlerCubit>();
        final inherited = UpsertTanksInherited.of(context);
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            dialog.onOpenNotification(
              message: 'Creando tanques',
              dialogType: DialogType.loading,
            );
          } else {
            dialog.onOpenNotification(
              message: 'Actualizando tanques',
              dialogType: DialogType.loading,
            );
          }
        } else if (s == UpsertStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? state.errorMessage ?? 'Error al crear tanques'
                  : state.errorMessage ?? 'Error al actualizar tanques',
              title: 'Error',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.error,
          );
        } else if (s == UpsertStatus.success) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Tanque creado exitosamente'
                  : 'Tanque actualizado exitosamente',
              title: inherited.typeOperation == TypeOperation.create
                  ? 'Creación exitosa'
                  : 'Actualización exitosa',
              onPressed: () {
                context.pop();
                Navigator.pop(context, true);
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.success,
          );
        }*/
      },
    );
  }

  static BlocListener<UpsertTanksCubit, UpsertTanksState> upsertTankPrepare() {
    return BlocListener<UpsertTanksCubit, UpsertTanksState>(
      listenWhen: (previous, current) =>
          previous.prepareStatus != current.prepareStatus,
      listener: (context, state) {
        /*final dialog = context.read<DialogHandlerCubit>();
        final prepare = state.prepareStatus;

        if (prepare == PrepareStatus.loading) {
          dialog.onOpenNotification(
            message: 'Preparando datos para la creación de tanques',
            dialogType: DialogType.loading,
          );
        } else if (prepare == PrepareStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: state.errorMessage ??
                  'Error al preparar los datos para la creación de tanques',
              title: 'Error',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.error,
          );
        } else if (prepare == PrepareStatus.success) {
          context.pop();
        }*/
      },
    );
  }
}
