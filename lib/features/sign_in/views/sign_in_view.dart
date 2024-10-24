import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/sign_in/helper/sign_in_listener.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        LoginListener.login(),
      ],
      child: const SignInBody(),
    );
  }
}
