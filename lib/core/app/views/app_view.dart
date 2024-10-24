import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/cubit/app_cubit.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/dialog_handler/bloc/dialog_handler_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/helpers/dialog_handler/widgets/dialog_handler.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/splash/splash.dart';
import 'package:tanks_app/injection/injection.dart';

part 'app_body.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => sl<AppCubit>()..verificationLogin(),
        ),
        BlocProvider(
          create: (context) => NotifyDialogHandlerCubit(),
        ),
        BlocProvider(
          create: (context) => DialogHandlerBloc(),
        ),
        BlocProvider(create: (context) => sl<SessionCubit>()),
        BlocProvider(create: (context) => sl<UserDeviceCubit>()),
      ],
      child: const AppBody(),
    );
  }
}
