import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/create_update/cubit/upsert_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/create_update/views/create_update_sales_center_inherited.dart';

class UpsertSalesCenterListener {
  static BlocListener<UpsertSalesCenterCubit, UpsertSalesCenterState>
      upserSalesCenter({
    void Function(UpsertStatus)? onTap,
  }) {
    return BlocListener<UpsertSalesCenterCubit, UpsertSalesCenterState>(
      listenWhen: (previous, current) =>
          previous.createUpdateStatus != current.createUpdateStatus,
      listener: (context, state) {
        final inherited = CreateUpdateSalesCenterInherited.of(context);
        final status = state.createUpdateStatus;
        final errorMessage = state.errorMessage;

        final isCreate = inherited.typeOperation == TypeOperation.create;

        if (status == UpsertStatus.loading) {
          final text = isCreate
              ? 'Registrando centro de venta...'
              : 'Actualizando centro de venta...';
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
                  ? 'No se pudo registrar el centro de venta.'
                  : 'No se pudo actualizar el centro de venta.');

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
              ? 'El centro de venta se ha registrado con éxito.'
              : 'El centro de venta se ha actualizado con éxito.';

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
