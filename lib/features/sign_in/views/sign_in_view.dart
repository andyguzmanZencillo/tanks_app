import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/list/views/article_list.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerCubit>();
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        final s = state.status;
        if (s == SignStatus.loading) {
          dialog.onOpenNotification(
            message: 'Iniciando sesión...',
            dialogType: DialogType.loading,
          );
        } else if (s == SignStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: 'Error al iniciar sesión',
              title: 'Error',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.error,
          );
        } else if (s == SignStatus.success) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: '¡Inicio de sesión exitoso!',
              title: 'Inicio correcto',
              onPressed: () {
                context.pop();
                context.push(ArticleList.route());
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.success,
          );
        }
      },
      child: const SignInBody(),
    );
  }
}
