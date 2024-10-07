import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/tank_variation/create_update/cubit/upsert_tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';

class UpsertTanksVariationListener {
  static BlocListener<UpsertTankVariationCubit, UpsertTankVariationState>
      upsertTankVariation() {
    return BlocListener<UpsertTankVariationCubit, UpsertTankVariationState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final inherited = UpsertTankVariationInherited.of(context);
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const DialogText(
                  text: 'Creando variación de tanque',
                );
              },
            );
          } else {
            showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const DialogText(
                  text: 'Actualizando Variación de tanque',
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
                      ? state.errorMessage ??
                          'Error al crear variación de tanques'
                      : state.errorMessage ??
                          'Error al actualizar variación de tanques',
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
                      ? 'Variación de tanque creado exitosamente'
                      : 'Variación de tanque actualizado exitosamente',
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
