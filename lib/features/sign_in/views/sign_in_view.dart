import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/home/views/home_page.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<SignInCubit, SignInState>().listen(),
        ListenerEvent<SignInCubit, SignInState>().event(
          onSuccess: () {
            context.read<UserDeviceCubit>().register();
            context.read<SessionCubit>().getUserEntity();
            context.go(HomePage.route());
          },
        ),
      ],
      child: const SignInBody(),
    );
  }
}
