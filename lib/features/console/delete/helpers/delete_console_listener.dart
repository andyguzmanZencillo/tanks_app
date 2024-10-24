import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/console/delete/cubit/delete_console_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class DeleteConsoleListener {
  static BlocListener<DeleteConsoleCubit, DeleteConsoleState> delete({
    void Function(DeleteStatus)? onTap,
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<DeleteConsoleCubit, DeleteConsoleState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        final status = state.deleteStatus;
        final errorMessage = state.errorMessage;

        if (status == DeleteStatus.loading) {
          loading?.call();
          const text = 'Eliminando consola de tanque...';
          FocusManager.instance.primaryFocus?.unfocus();
          context.show(
            const DialogText(
              text: text,
            ),
          );
        } else if (status == DeleteStatus.error) {
          context.pop();
          error?.call();
          final message =
              errorMessage ?? 'No se pudo eliminar la consola de tanque.';
          context.show(
            DialogManagment.error(
              dialogData: DialogData(
                barrierDismissible: false,
                message: message,
                title: 'Error al eliminar consola de tanque',
                onPressed: () {
                  onTap?.call(status);
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
            ),
          );
        } else if (status == DeleteStatus.success) {
          context.pop();
          success?.call();
          context.show(
            DialogManagment.good(
              dialogData: DialogData(
                barrierDismissible: false,
                message: 'Eliminación exitosa de la consola de tanque.',
                title: 'Consola de tanque eliminada',
                onPressed: () {
                  onTap?.call(status);
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
            ),
          );
        }
      },
    );
  }
}
