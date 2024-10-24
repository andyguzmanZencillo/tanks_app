import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';

class SalesCenterDeleteListener {
  static BlocListener<DeleteSalesCenterCubit, DeleteSalesCenterState> delete({
    void Function(DeleteStatus)? onTap,
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<DeleteSalesCenterCubit, DeleteSalesCenterState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        final status = state.deleteStatus;
        final errorMessage = state.errorMessage;

        if (status == DeleteStatus.loading) {
          loading?.call();
          const text = 'Eliminando centro de venta...';
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
              errorMessage ?? 'No se pudo eliminar el centro de venta.';
          context.show(
            DialogManagment.error(
              dialogData: DialogData(
                barrierDismissible: false,
                message: message,
                title: 'Error al eliminar centro de venta',
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
                message: 'Eliminación exitosa del centro de venta.',
                title: 'Centro de venta eliminado',
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

extension ContextDialog on BuildContext {
  void show(Widget child) {
    showDialog<void>(
      barrierDismissible: false,
      context: this,
      builder: (context) {
        return child;
      },
    );
  }
}
