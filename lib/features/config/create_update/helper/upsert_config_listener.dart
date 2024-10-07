import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/config/create_update/cubit/upsert_config_cubit.dart';
import 'package:tanks_app/features/config/create_update/helper/upsert_config_inherited.dart';

class UpsertConfigistener {
  static BlocListener<UpsertConfigCubit, UpsertConfigState>
      upsertTankVariation() {
    return BlocListener<UpsertConfigCubit, UpsertConfigState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final inherited = UpsertConfigInherited.of(context);
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const DialogText(
                  text: 'Creando configuración',
                );
              },
            );
          } else {
            showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const DialogText(
                  text: 'Actualizando configuración',
                );
              },
            );
          }
        } else if (s == UpsertStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: inherited.typeOperation == TypeOperation.create
                      ? state.errorMessage ?? 'Error al crear una configuración'
                      : state.errorMessage ??
                          'Error al actualizar una configuración',
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
                  message: inherited.typeOperation == TypeOperation.create
                      ? 'Configuración creada exitosamente'
                      : 'Configuración actualizada exitosamente',
                  title: inherited.typeOperation == TypeOperation.create
                      ? 'Creación exitosa'
                      : 'Actualización exitosa',
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
