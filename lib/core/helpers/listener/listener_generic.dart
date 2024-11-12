import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';

abstract class StatusState {
  GeneralStatus get generalStatus;
  DialogMessage get dialogMessage;
}

class Listener<B extends BlocBase<S>, S extends StatusState> {
  BlocListener<B, S> listen() {
    return BlocListener<B, S>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        final message = state.dialogMessage;

        if (status == GeneralStatus.loading) {
          context.showLoading(
            message: message.message,
          );
        } else if (status == GeneralStatus.error) {
          context.pop();

          context.showError(
            message: message.message,
            title: message.title ?? 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (status == GeneralStatus.success) {
          context.pop();

          context.showGood(
            message: message.message,
            title: message.title ?? '¡Éxito!',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        }
      },
    );
  }
}

class ListenerPro<B extends BlocBase<S>, S extends StatusState> {
  BlocListener<B, S> listen({
    void Function()? onPressedError,
    void Function()? onPressedSuccess,
  }) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        final message = state.dialogMessage;

        if (status == GeneralStatus.loading) {
          if (message.showDialog) {
            context.showLoading(
              message: message.message,
            );
          }
        } else if (status == GeneralStatus.error) {
          context.pop();
          if (message.showError) {
            context.showError(
              message: message.message,
              title: message.title ?? 'Error',
              onPressed: () {
                if (message.pop) {
                  context.pop();
                }
                onPressedError?.call();
              },
              textButton: 'Cerrar',
            );
          }
        } else if (status == GeneralStatus.success) {
          context.pop();
          if (message.showSuccess) {
            context.showGood(
              message: message.message,
              title: message.title ?? '¡Éxito!',
              onPressed: () {
                if (message.pop) {
                  context.pop();
                }
                onPressedSuccess?.call();
              },
              textButton: 'Cerrar',
            );
          }
        }
      },
    );
  }
}

class ListenerEvent<B extends BlocBase<S>, S extends StatusState> {
  BlocListener<B, S> event({
    void Function()? onError,
    void Function()? onSuccess,
    void Function()? onLoading,
  }) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        if (status == GeneralStatus.loading) {
          onLoading?.call();
        } else if (status == GeneralStatus.error) {
          onError?.call();
        } else if (status == GeneralStatus.success) {
          onSuccess?.call();
        }
      },
    );
  }
}
