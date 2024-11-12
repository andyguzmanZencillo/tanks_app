import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';
import 'package:tanks_app/features/profile/alert/cubit/alert_cubit.dart';
import 'package:tanks_app/features/profile/config_notification/views/config_notification_view.dart';
import 'package:tanks_app/features/profile/notification/notification_cubit.dart';
import 'package:tanks_app/features/profile/user_alert/user_alert_cubit.dart';
import 'package:tanks_app/features/profile/user_notification/notification_cubit.dart';

class AlertNotification extends StatelessWidget {
  const AlertNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final alertCubit = context.read<AlertCubit>();
    final userAlertCubit = context.read<UserAlertCubit>();
    final userNotificationCubit = context.read<UserNotificationCubit>();
    final notificationCubit = context.read<NotificationCubit>();
    return FullWidgetGeneric(
      onInit: () async {
        await notificationCubit.getAll();
        await userNotificationCubit.getAll();

        await alertCubit.getAll();
        await userAlertCubit.getAll();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const Spacer(),
                GenericButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    context.pushComplete(
                      MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: alertCubit),
                          BlocProvider.value(value: notificationCubit),
                          BlocProvider.value(value: userAlertCubit),
                          BlocProvider.value(value: userNotificationCubit),
                        ],
                        child: const ConfigNotificationPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.status == GeneralStatus.loading) {
                  return const Center(
                    child: Text(
                      'Buscando notificaciones...',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                final listNotification = state.list;

                if (listNotification.isNotEmpty) {
                  return BlocBuilder<UserNotificationCubit,
                      UserNotificationState>(
                    builder: (context, state) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.list.map((item) {
                          final i = listNotification.firstWhereOrNull(
                            (e) => e.idNotificacion == item.idNotificacion,
                          );
                          return Chip(
                            label: Text(
                              i?.nombreNotificacion ?? '',
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text(
                    'No hay notificaciones configuradas',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Alertas',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<AlertCubit, AlertState>(
              builder: (context, state) {
                if (state.status == GeneralStatus.loading) {
                  return const Center(
                    child: Text(
                      'Buscando Alertas..',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                final listAlert = state.list;

                if (listAlert.isNotEmpty) {
                  return BlocBuilder<UserAlertCubit, UserAlertState>(
                    builder: (context, state) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.list.map((item) {
                          final i = listAlert.firstWhereOrNull(
                            (e) => e.idAlerta == item.idAlerta,
                          );
                          return Chip(
                            label: Text(
                              i?.nombreAlerta ?? '',
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text(
                    'No hay alertas configuradas',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
