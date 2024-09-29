import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_view.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_inherited.dart';
import 'package:tanks_app/injection/injection.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInCubit>(),
      child: SignUpInherited(child: const SignInView()),
    );
  }
}
