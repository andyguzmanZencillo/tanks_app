import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/cubit/app_cubit.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/home/views/home_page.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_page.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) async {
        if (state.status == AppStatus.loged) {
          await sessionCubit.getUserEntity();
          // ignore: use_build_context_synchronously
          await context.read<UserDeviceCubit>().register();
          // ignore: use_build_context_synchronously
          context.go(HomePage.route());
        } else if (state.status == AppStatus.noLoged) {
          context.go(SignInPage.route());
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            color: Color.fromARGB(255, 243, 170, 25),
          ),
        ),
      ),
    );
  }
}
