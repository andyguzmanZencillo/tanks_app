import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/helpers/user_device/helpers/user_device_listener.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';
import 'package:tanks_app/features/profile/config_notification/views/config_notification_view.dart';
import 'package:tanks_app/features/profile/get_alert/get_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_notification/get_notification_cubit.dart';
import 'package:tanks_app/features/profile/get_user_alert/get_user_alert_cubit.dart';
import 'package:tanks_app/features/profile/get_user_notification/get_notification_cubit.dart';
import 'package:tanks_app/features/profile/perfil/cubit/perfil_cubit.dart';
import 'package:tanks_app/features/profile/perfil/helpers/perfil_listeners.dart';
import 'package:tanks_app/features/profile/perfil/widgets/config_devices.dart';
import 'package:tanks_app/features/profile/perfil/widgets/info_general.dart';
import 'package:tanks_app/features/profile/perfil/widgets/info_user.dart';
import 'package:tanks_app/injection/injection.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GetNotificationCubit>()),
        BlocProvider(create: (_) => sl<GetAlertCubit>()),
        BlocProvider(create: (context) => sl<GetUserAlertCubit>()),
        BlocProvider(create: (context) => sl<GetUserNotificationCubit>()),
        BlocProvider(
          create: (context) => sl<PerfilCubit>(),
        ),
        BlocProvider(create: (_) => sl<UserDeviceCubit>()),
      ],
      child: const PerfilView(),
    );
  }
}

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        PerfilListener.user(),
        UserDeviceListener.userDevice(
          onTap: (s, o) {
            if (o == OperationType.delete && s == GeneralStatus.success) {
              context.read<UserDeviceCubit>().getAll();
            }
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<PerfilCubit>().getInfo();
          context.read<GetAlertCubit>().getAlerts();
          context.read<GetNotificationCubit>().getNotifications();
          context.read<GetUserAlertCubit>().getAll();
          context.read<GetUserNotificationCubit>().getAll();
          context.read<UserDeviceCubit>().getAll();
        },
        child: const PerfilBody(),
      ),
    );
  }
}

class PerfilBody extends StatelessWidget {
  const PerfilBody({super.key});

  @override
  Widget build(BuildContext context) {
    final getNotiCubit = context.read<GetNotificationCubit>();
    final getAlertCubit = context.read<GetAlertCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil de usuario',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: BlueStoneColors.blueStone50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<PerfilCubit, PerfilState>(
              builder: (context, state) {
                final user = state.user;
                return Column(
                  children: [
                    InfoGeneral(userEntity: user),
                    InfoUser(user: user),
                  ],
                );
              },
            ),
            Container(
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
                                BlocProvider.value(
                                  value: context.read<GetAlertCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<GetNotificationCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<GetUserAlertCubit>(),
                                ),
                                BlocProvider.value(
                                  value:
                                      context.read<GetUserNotificationCubit>(),
                                ),
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
                  BlocBuilder<GetUserNotificationCubit,
                      GetUserNotificationState>(
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
                      if (state.list.isNotEmpty) {
                        final listNoti = getNotiCubit.state.list;
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.list.map((item) {
                            final i = listNoti.firstWhereOrNull(
                              (e) => e.idNotificacion == item.idNotificacion,
                            );
                            return Chip(
                              label: Text(
                                i?.nombreNotificacion ?? '',
                              ),
                            );
                          }).toList(),
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
                  BlocBuilder<GetUserAlertCubit, GetUserAlertState>(
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
                      if (state.list.isNotEmpty) {
                        final listAlerts = getAlertCubit.state.list;

                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.list.map((item) {
                            final i = listAlerts.firstWhereOrNull(
                              (element) => element.idAlerta == item.idAlerta,
                            );
                            return Chip(
                              label: Text(
                                i?.nombreAlerta ?? '',
                              ),
                            );
                          }).toList(),
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
            const ConfigDevices(),
          ],
        ),
      ),
    );
  }
}
