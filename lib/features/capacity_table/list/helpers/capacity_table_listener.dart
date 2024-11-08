import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class CapacityTableListener {
  static BlocListener<CapacityTableCubit, CapacityTableState> capacityTable() {
    return BlocListener<CapacityTableCubit, CapacityTableState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final message = state.errorMessage;

        if (status == GeneralStatus.loading) {
          context.showLoading(
            message:
                'Estamos obteniendo la tabla de aforo. Por favor, espere...',
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          /*context.showError(
            message: message ??
                'No pudimos cargar la tabla de aforo. Verifique su conexión e intente de nuevo.',
            title: 'Error al cargar la tabla de aforo',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );*/
        } else if (status == GeneralStatus.success) {
          context.pop();
        }
      },
    );
  }
}
