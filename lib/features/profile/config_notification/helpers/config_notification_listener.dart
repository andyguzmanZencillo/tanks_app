import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/profile/config_notification/cubit/config_notification_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class ConfigNotificationListener {
  static BlocListener<ConfigNotificationCubit, ConfigNotificationState>
      configNotification({
    void Function()? onTap,
  }) {
    return BlocListener<ConfigNotificationCubit, ConfigNotificationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final message = state.errorMessage;

        if (status == GeneralStatus.loading) {
          context.show(
            const DialogText(
              text: 'Guardando configuración de notificaciones...',
            ),
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          context.show(
            DialogManagment.error(
              dialogData: DialogData(
                barrierDismissible: false,
                message: message ??
                    'Error al guardar configuración de notificaciones',
                title: 'Error',
                onPressed: () {
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
            ),
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
          context.show(
            DialogManagment.good(
              dialogData: DialogData(
                barrierDismissible: false,
                message:
                    'Configuración de notificaciones guardada exitosamente',
                title: 'Éxito',
                onPressed: () {
                  context.pop();
                  context.pop();
                  onTap?.call();
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
