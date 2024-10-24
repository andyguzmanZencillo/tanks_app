import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';

class SalesCenterListener {
  static BlocListener<SalesCenterCubit, SalesCenterState> salesCenter({
    void Function(SalesCenterStatus status)? onTap,
  }) {
    return BlocListener<SalesCenterCubit, SalesCenterState>(
      listenWhen: (previous, current) =>
          previous.salesCenterStatus != current.salesCenterStatus,
      listener: (context, state) {
        final status = state.salesCenterStatus;
        final message = state.errorMessage;

        if (status == SalesCenterStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text:
                    'Estamos buscando los centros de venta. Por favor, espere...',
              );
            },
          );
        } else if (status == SalesCenterStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ??
                      'No pudimos cargar los centros de venta. Verifique su conexión e intente de nuevo.',
                  title: 'Error al cargar',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == SalesCenterStatus.success) {
          context.pop();
        }
      },
    );
  }
}
