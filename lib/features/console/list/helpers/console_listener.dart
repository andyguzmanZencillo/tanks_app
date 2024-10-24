import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';

class ConsoleListener {
  static BlocListener<ConsoleCubit, ConsoleState> console({
    void Function(SalesCenterStatus status)? onTap,
  }) {
    return BlocListener<ConsoleCubit, ConsoleState>(
      listenWhen: (previous, current) =>
          previous.consoleStatus != current.consoleStatus,
      listener: (context, state) {
        final status = state.consoleStatus;
        final message = state.errorMessage;

        if (status == ConsoleStatus.loading) {
          context.show(
            const DialogText(
              text:
                  'Estamos buscando la consola de tanques. Por favor, espere...',
            ),
          );
        } else if (status == ConsoleStatus.error) {
          context.pop();
          context.show(
            DialogManagment.error(
              dialogData: DialogData(
                barrierDismissible: false,
                message: message ??
                    'No pudimos cargar la consola de tanques. Verifique su conexión e intente de nuevo.',
                title: 'Error al cargar',
                onPressed: () {
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
            ),
          );
        } else if (status == ConsoleStatus.success) {
          context.pop();
          // Aquí podrías agregar una notificación de éxito si es necesario
          // context.show(...) para un diálogo de éxito, si se desea.
        }
      },
    );
  }
}
