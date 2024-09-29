import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_inherited.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_view.dart';
import 'package:tanks_app/injection/injection.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const SignUpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: SignUpInherited(child: const SignUpView()),
    );
  }
}
