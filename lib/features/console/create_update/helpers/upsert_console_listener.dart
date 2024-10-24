import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/console/create_update/cubit/upsert_console_cubit.dart';
import 'package:tanks_app/features/console/create_update/views/upsert_console_inherited.dart';

class UpsertConsoleListener {
  static BlocListener<UpsertConsoleCubit, UpsertConsoleState> upsertConsole({
    void Function(UpsertStatus)? onTap,
  }) {
    return BlocListener<UpsertConsoleCubit, UpsertConsoleState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final inherited = UpsertConsoleInherited.of(context);
        final status = state.upsertStatus;
        final errorMessage = state.errorMessage;

        final isCreate = inherited.typeOperation == TypeOperation.create;

        if (status == UpsertStatus.loading) {
          final text = isCreate
              ? 'Registrando consola de tanques...'
              : 'Actualizando consola de tanques...';
          FocusManager.instance.primaryFocus?.unfocus();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogText(
                text: text,
              );
            },
          );
        } else if (status == UpsertStatus.error) {
          final title =
              isCreate ? 'Error de Registro' : 'Error de Actualización';
          final message = errorMessage ??
              (isCreate
                  ? 'No se pudo registrar la consola de tanques.'
                  : 'No se pudo actualizar la consola de tanques.');

          context.pop();

          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message,
                  title: title,
                  onPressed: () {
                    context.pop();
                    onTap?.call(status);
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == UpsertStatus.success) {
          final title = isCreate ? 'Registro Exitoso' : 'Actualización Exitosa';
          final message = isCreate
              ? 'La consola de tanques se ha registrado con éxito.'
              : 'La consola de tanques se ha actualizado con éxito.';

          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.good(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message,
                  title: title,
                  onPressed: () {
                    context.pop();
                    context.pop();
                    onTap?.call(status);
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
