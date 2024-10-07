import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

class ListTanksListener {
  static BlocListener<TanksCubit, TanksState> tanks() {
    return BlocListener<TanksCubit, TanksState>(
      listenWhen: (previous, current) =>
          previous.tanksStatus != current.tanksStatus,
      listener: (context, state) {
        final status = state.tanksStatus;
        final message = state.messageError;

        if (status == TanksStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando tanques...',
              );
            },
          );
        } else if (status == TanksStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ?? 'Error al buscar tanques',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == TanksStatus.success) {
          context.pop();
        }
      },
    );
  }
}
