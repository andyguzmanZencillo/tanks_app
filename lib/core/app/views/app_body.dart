part of 'app_view.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      locale: const Locale('es', 'ES'),
      title: 'Tanques',
      theme: blueStoneTheme, // Aquí aplicamos el tema personalizado
      home: const MultiChannelAlertProcessor(child: SplashView()),
    );
  }
}

class MultiChannelAlertProcessor extends StatelessWidget {
  const MultiChannelAlertProcessor({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dialogCubit = context.read<DialogHandlerBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<DialogHandlerBloc, DialogHandlerState>(
          listenWhen: (previous, current) {
            return current.closeManually;
          },
          listener: (context, state) {
            if (state.closeManually) {
              context.pop();
            }
          },
        ),
        BlocListener<DialogHandlerBloc, DialogHandlerState>(
          listenWhen: (previous, current) {
            if (previous != current) {
              if (previous.dialogState != current.dialogState) {
                return current.dialogState == DialogState.open;
              }
            }
            return false;
          },
          listener: (context, state) {
            if (state.dialogState == DialogState.open) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: dialogCubit,
                    child: const DialogHandler(),
                  );
                },
              ).then((s) {
                dialogCubit.add(const ChangeStateDialog(DialogState.close));
              });
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
