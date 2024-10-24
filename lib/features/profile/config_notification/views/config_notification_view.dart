import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button/custom_elevate_button.dart';
import 'package:tanks_app/features/profile/config_notification/cubit/config_notification_cubit.dart';
import 'package:tanks_app/features/profile/config_notification/helpers/config_notification_listener.dart';
import 'package:tanks_app/features/profile/get_alert/get_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_notification/get_notification_cubit.dart';
import 'package:tanks_app/features/profile/get_user_alert/get_user_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_user_notification/get_notification_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class ConfigNotificationPage extends StatelessWidget {
  const ConfigNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ConfigNotificationCubit>()),
      ],
      child: const ConfigNotificationView(),
    );
  }
}

class ConfigNotificationView extends StatelessWidget {
  const ConfigNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ConfigNotificationListener.configNotification(
          onTap: () {
            context.read<GetUserAlertCubit>().getAll();
            context.read<GetUserNotificationCubit>().getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {},
        child: const ConfigNotificationBody(),
      ),
    );
  }
}

class ConfigNotificationBody extends StatelessWidget {
  const ConfigNotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final getNotificationCubit = context.read<GetNotificationCubit>();
    final getAlertCubit = context.read<GetAlertCubit>();
    final configNotification = context.read<ConfigNotificationCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurar notificaciones',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Notificaciones',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            BlocBuilder<GetNotificationCubit, GetNotificationState>(
              builder: (context, state) {
                final list = [...state.list];
                final listSelected = [...state.listSelected];

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: list.map((item) {
                    final isSelected = listSelected
                        .any((e) => e.idNotificacion == item.idNotificacion);
                    return GestureDetector(
                      onTap: () {
                        getNotificationCubit.onChangeListSelected(item);
                      },
                      child: Chip(
                        backgroundColor:
                            isSelected ? BlueStoneColors.blueStone700 : null,
                        label: Text(
                          item.nombreNotificacion,
                          style: TextStyle(
                            color: isSelected
                                ? BlueStoneColors.blueStone100
                                : null,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              'Alertas',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            BlocBuilder<GetAlertCubit, GetAlertState>(
              builder: (context, state) {
                final list = [...state.list];
                final listSelected = [...state.listSelected];

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: list.map((item) {
                    final isSelected =
                        listSelected.any((e) => e.idAlerta == item.idAlerta);
                    return GestureDetector(
                      onTap: () {
                        getAlertCubit.onChangeListSelected(item);
                      },
                      child: Chip(
                        backgroundColor:
                            isSelected ? BlueStoneColors.blueStone700 : null,
                        label: Text(
                          item.nombreAlerta,
                          style: TextStyle(
                            color: isSelected
                                ? BlueStoneColors.blueStone100
                                : null,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevateButton(
              onPressed: () {
                final listNoti = getNotificationCubit.state.listSelected;
                final listAlert = getAlertCubit.state.listSelected;
                if (listNoti.isEmpty) {
                  ElegantNotification.error(
                    description: const Text(
                      'Seleccione una o mas notificaciones para registrar.',
                    ),
                  ).show(context);
                  return;
                }

                if (listAlert.isEmpty) {
                  ElegantNotification.error(
                    description: const Text(
                      'Seleccione una o mas alertas para registrar.',
                    ),
                  ).show(context);
                  return;
                }

                configNotification.save(
                  idAlerta: listAlert.map((e) => e.idAlerta).toList(),
                  idNotificacion:
                      listNoti.map((e) => e.idNotificacion).toList(),
                );
              },
              text: 'Registrar Notificaciones',
            ),
          ],
        ),
      ),
    );
  }
}
