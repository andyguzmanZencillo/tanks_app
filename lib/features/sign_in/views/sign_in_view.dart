import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SignInBody(),
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
                child: DialogInfo.error(
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
                child: DialogInfo.good(
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
