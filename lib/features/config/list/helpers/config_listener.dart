import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/config/list/cubit/config_cubit.dart';

class ConfigListener {
  static BlocListener<ConfigCubit, ConfigState> config() {
    return BlocListener<ConfigCubit, ConfigState>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final s = state.generalStatus;
        final message = state.errorMessage;
        if (s == GeneralStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando configuraciones...',
              );
            },
          );
        } else if (s == GeneralStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ?? 'Error al buscar configuraciones',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (s == GeneralStatus.success) {
          context.pop();
        }
      },
    );
  }
}
