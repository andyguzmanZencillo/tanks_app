import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_inherited.dart';

class UpsertTanksListener {
  static BlocListener<UpsertTanksCubit, UpsertTanksState> upsertTank({
    void Function()? onTap,
  }) {
    return BlocListener<UpsertTanksCubit, UpsertTanksState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final inherited = UpsertTanksInherited.of(context);
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            context.showLoading(
              message: 'Creando tanques',
            );
          } else {
            context.showLoading(
              message: 'Actualizando tanques',
            );
          }
        } else if (s == UpsertStatus.error) {
          context.pop();
          context.showError(
            message: inherited.typeOperation == TypeOperation.create
                ? state.errorMessage ?? 'Error al crear tanques'
                : state.errorMessage ?? 'Error al actualizar tanques',
            title: 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (s == UpsertStatus.success) {
          context.pop();
          context.showGood(
            message: inherited.typeOperation == TypeOperation.create
                ? 'Tanque creado exitosamente'
                : 'Tanque actualizado exitosamente',
            title: inherited.typeOperation == TypeOperation.create
                ? 'Creación exitosa'
                : 'Actualización exitosa',
            onPressed: () {
              context.pop();
              context.pop();
              onTap?.call();
            },
            textButton: 'Cerrar',
          );
        }
      },
    );
  }

  static BlocListener<UpsertTanksCubit, UpsertTanksState> upsertTankPrepare() {
    return BlocListener<UpsertTanksCubit, UpsertTanksState>(
      listenWhen: (previous, current) =>
          previous.prepareStatus != current.prepareStatus,
      listener: (context, state) {
        final prepare = state.prepareStatus;

        if (prepare == PrepareStatus.loading) {
          context.showLoading(
            message: 'Preparando datos para la creación de tanques',
          );
        } else if (prepare == PrepareStatus.error) {
          context.showError(
            message: state.errorMessage ??
                'Error al preparar los datos para la creación de tanques',
            title: 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (prepare == PrepareStatus.success) {
          context.pop();
        }
      },
    );
  }
}
