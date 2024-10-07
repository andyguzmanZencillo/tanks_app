import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';

class BinnacleListener {
  static BlocListener<BinnacleCubit, BinnacleState> config() {
    return BlocListener<BinnacleCubit, BinnacleState>(
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
                text: 'Buscando bitacoras',
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
                  message: message ?? 'Error al buscar bitacoras',
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
