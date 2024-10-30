import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/token/token_cubit.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class TokenListener {
  static BlocListener<TokenCubit, TokenState> article({
    void Function()? onTap,
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<TokenCubit, TokenState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final errorMessage = state.errorMessage;

        if (status == GeneralStatus.loading) {
          FocusManager.instance.primaryFocus?.unfocus();
          const text =
              'Estamos obteniendo su token de acceso. Esto puede tardar unos momentos...';

          context.showLoading(
            message: text,
          );
        } else if (status == GeneralStatus.error) {
          final message = errorMessage ??
              'Ocurrió un error al intentar eliminar el artículo. Por favor, inténtelo nuevamente.';

          context.pop();

          context.showError(
            message: message,
            title: 'Error en la eliminación del artículo',
            onPressed: () {
              onTap?.call();
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
          context.showGood(
            message:
                'El artículo fue eliminado exitosamente de la base de datos.',
            title: 'Artículo eliminado con éxito',
            onPressed: () {
              onTap?.call();
              context.pop();
            },
            textButton: 'Cerrar',
          );
        }
      },
    );
  }
}
