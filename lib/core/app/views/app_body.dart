part of 'app_view.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanques',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      home: const MultiChannelAlertProcessor(child: SignInPage()),
    );
  }
}

class MultiChannelAlertProcessor extends StatelessWidget {
  const MultiChannelAlertProcessor({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DialogHandlerCubit, DialogHandlerState>(
          listenWhen: (previous, current) {
            return current.dialogInfo != const DialogInfo.empty();
          },
          listener: (context, state) {
            final dialogData = state.dialogInfo.dialogData;
            if (dialogData == null) return;
            final status = state.dialogInfo.dialogType;
            context.read<DialogHandlerCubit>().onNotification(
                  const DialogInfo.empty(),
                );

            if (status == DialogType.success) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return DialogManagment.good(
                    dialogData: dialogData,
                  );
                },
              );
            } else if (status == DialogType.info) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return DialogManagment.info(
                    dialogData: dialogData,
                  );
                },
              );
            } else if (status == DialogType.error) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return DialogManagment.error(
                    dialogData: dialogData,
                  );
                },
              );
            }
          },
        ),
        BlocListener<NotifyDialogHandlerCubit, NotifyDialogHandlerState>(
          listenWhen: (previous, current) {
            return current.notification != const NotificationInfo.empty();
          },
          listener: (context, state) {
            final message = state.notification.message;
            final title = state.notification.title;
            final status = state.notification.notificationType;
            context.read<NotifyDialogHandlerCubit>().onNotification(
                  const NotificationInfo.empty(),
                );

            if (NotificationType.success == status) {
              ElegantNotification.success(
                title: title != null
                    ? Text(title, style: const TextStyle(color: Colors.black))
                    : null,
                description:
                    Text(message, style: const TextStyle(color: Colors.black)),
              ).show(context);
            } else if (NotificationType.error == status) {
              ElegantNotification.error(
                title: title != null
                    ? Text(
                        title,
                        style: const TextStyle(color: Colors.black),
                      )
                    : null,
                description:
                    Text(message, style: const TextStyle(color: Colors.black)),
              ).show(context);
              return;
            } else if (NotificationType.info == status) {
              ElegantNotification.info(
                title: title != null
                    ? Text(title, style: const TextStyle(color: Colors.black))
                    : null,
                description:
                    Text(message, style: const TextStyle(color: Colors.black)),
              ).show(context);
              return;
            }
          },
        ),
      ],
      child: child,
    );
  }
}
