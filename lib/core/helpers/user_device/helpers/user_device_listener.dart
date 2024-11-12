import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';

class UserDeviceListener {
  static BlocListener<UserDeviceCubit, UserDeviceState> userDevice({
    void Function(GeneralStatus, OperationType)? onTap,
  }) {
    return BlocListener<UserDeviceCubit, UserDeviceState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final type = state.operationType;
        final message = state.message;

        if (status == GeneralStatus.loading) {
          if (type == OperationType.delete) {
            context.showLoading(
              message:
                  'Eliminando el dispositivo seleccionado, por favor espere...',
            );
          }
        } else if (status == GeneralStatus.error) {
          if (type == OperationType.delete) {
            context.pop();
            context.showError(
              message: message ??
                  'No se pudo eliminar el dispositivo. Inténtelo de nuevo.',
              title: 'Error al eliminar dispositivo',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            );
          }
        } else if (status == GeneralStatus.success) {
          if (type == OperationType.delete) {
            context.pop();
            context.showGood(
              message: 'El dispositivo fue eliminado correctamente.',
              title: 'Dispositivo eliminado',
              onPressed: () {
                context.pop();
                onTap?.call(status, state.operationType);
              },
              textButton: 'Cerrar',
            );
          }
        }
      },
    );
  }
}
