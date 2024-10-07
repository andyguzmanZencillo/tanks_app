import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/bloc/dialog_handler_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/home/views/home_page.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerBloc>();
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        final s = state.status;
        if (s == SignUpStatus.loading) {
          dialog.add(
            const OnOpenNotification(
              message: 'Registrando usuario...',
              dialogType: DialogType.loading,
            ),
          );
        } else if (s == SignUpStatus.error) {
          dialog.add(
            OnOpenNotification(
              dialogData: DialogData(
                barrierDismissible: false,
                message: 'Error al registrar',
                title: 'Error',
                onPressed: () {
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
              dialogType: DialogType.error,
            ),
          );
        } else if (s == SignUpStatus.success) {
          dialog.add(
            OnOpenNotification(
              dialogData: DialogData(
                barrierDismissible: false,
                message: 'Registro exitoso!',
                title: '¡Exito!',
                onPressed: () {
                  context.pop();
                  context.push(HomePage.route());
                },
                textButton: 'Cerrar',
              ),
              dialogType: DialogType.success,
            ),
          );
        }
      },
      child: const SignUpBody(),
    );
  }
}
