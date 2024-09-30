import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerCubit>();
    return Stack(
      children: [
        BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            final s = state.status;
            if (s == SignStatus.loading) {
              const ColoredBox(
                color: Color.fromARGB(117, 0, 0, 0),
                child: DialogText(
                  text: 'Iniciando Sesión...',
                ),
              );
            } else if (s == SignStatus.error) {
              dialog.onNotification(
                DialogInfo(
                  dialogData: DialogData(
                    barrierDismissible: false,
                    message: 'Sincronización fallida',
                    title: 'Error',
                    onPressed: () {},
                    textButton: 'Cerrar',
                  ),
                  dialogType: DialogType.error,
                ),
              );
            } else if (s == SignStatus.success) {
              dialog.onNotification(
                DialogInfo(
                  dialogData: DialogData(
                    barrierDismissible: false,
                    message: '¡Inicio de sesión exitoso!',
                    title: 'Inicio correcto',
                    onPressed: () {},
                    textButton: 'Cerrar',
                  ),
                  dialogType: DialogType.success,
                ),
              );
            }
          },
          child: const SignInBody(),
        ),
        BlocSelector<SignInCubit, SignInState, SignStatus>(
          selector: (state) => state.status,
          builder: (c, s) {
            if (s == SignStatus.loading) {
              return const ColoredBox(
                color: Color.fromARGB(117, 0, 0, 0),
                child: DialogText(
                  text: 'Iniciando Sesión...',
                ),
              );
            } else if (s == SignStatus.error) {
              return ColoredBox(
                color: const Color.fromARGB(117, 0, 0, 0),
                child: DialogManagment.error(
                  dialogData: DialogData(
                    barrierDismissible: false,
                    message: 'Sincronización fallida',
                    title: 'Error',
                    onPressed: () {},
                    textButton: 'Cerrar',
                  ),
                ),
              );
            } else if (s == SignStatus.success) {
              return ColoredBox(
                color: const Color.fromARGB(117, 0, 0, 0),
                child: DialogManagment.good(
                  dialogData: DialogData(
                    barrierDismissible: false,
                    message: '¡Inicio de sesión exitoso!',
                    title: 'Inicio correcto',
                    onPressed: () {},
                    textButton: 'Cerrar',
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
