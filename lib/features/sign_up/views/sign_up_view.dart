import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/home/views/home_page.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        final s = state.status;
        if (s == SignUpStatus.loading) {
          FocusManager.instance.primaryFocus?.unfocus();
          context.showLoading(
            message: 'Registrando usuario...',
          );
        } else if (s == SignUpStatus.error) {
          context.pop();
          context.showError(
            message: state.errorMessage ?? 'Error al registrar',
            title: 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (s == SignUpStatus.success) {
          final sessionCubit = context.read<SessionCubit>();
          context.pop();
          sessionCubit.getUserEntity();
          context.push(HomePage.route());
        }
      },
      child: const SignUpBody(),
    );
  }
}
