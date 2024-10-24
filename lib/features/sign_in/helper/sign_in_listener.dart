import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/home/views/home_page.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';

class LoginListener {
  static BlocListener<SignInCubit, SignInState> login() {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final s = state.status;
        if (s == SignStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Iniciando sesión...',
              );
            },
          );
        } else if (s == SignStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: state.errorMessage ?? 'Error al iniciar sesión',
                  title: 'Error al iniciar sesión',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (s == SignStatus.success) {
          context.pop();
          context.read<UserDeviceCubit>().register();
          context.go(HomePage.route());
        }
      },
    );
  }
}
