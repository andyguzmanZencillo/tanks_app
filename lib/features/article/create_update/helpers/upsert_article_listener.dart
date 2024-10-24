import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertArticleListener {
  static BlocListener<CreateUpdateCubit, CreateUpdateState> article() {
    return BlocListener<CreateUpdateCubit, CreateUpdateState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        final inherited = UpsertArticleInherited.of(context);
        final status = state.upsertStatus;
        final errorMessage = state.errorMessage;

        final isCreate = inherited.typeOperation == TypeOperation.create;

        if (status == UpsertStatus.loading) {
          final text =
              isCreate ? 'Registrando artículo...' : 'Actualizando artículo...';
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
                  ? 'No se pudo registrar el artículo.'
                  : 'No se pudo actualizar el artículo.');

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
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == UpsertStatus.success) {
          final title = isCreate ? 'Registro Exitoso' : 'Actualización Exitosa';
          final message = isCreate
              ? 'El artículo se ha registrado con éxito.'
              : 'El artículo se ha actualizado con éxito.';

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

  static BlocListener<CreateUpdateCubit, CreateUpdateState> event({
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<CreateUpdateCubit, CreateUpdateState>(
      listenWhen: (previous, current) =>
          previous.upsertStatus != current.upsertStatus,
      listener: (context, state) {
        if (state.upsertStatus == UpsertStatus.loading) {
          loading?.call();
        } else if (state.upsertStatus == UpsertStatus.error) {
          error?.call();
        } else if (state.upsertStatus == UpsertStatus.success) {
          success?.call();
        }
      },
    );
  }
}
