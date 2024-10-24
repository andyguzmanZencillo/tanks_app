import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/constans/assets.dart';
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
      listeners: [PerfilListener.user()],
      child: FullWidgetGeneric(
        onInit: () {
          unawaited(() async {
            await context.read<PerfilCubit>().getInfo();
            await context.read<GetAlertCubit>().getAlerts();
            await context.read<GetNotificationCubit>().getNotifications();
            await context.read<GetUserAlertCubit>().getAll();
            await context.read<GetUserNotificationCubit>().getAll();
          }());
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
      body: BlocBuilder<PerfilCubit, PerfilState>(
        builder: (context, state) {
          final user = state.user;
          return SizedBox(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.all(5),
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: BlueStoneColors.blueStone600,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Image.asset(
                                height: 120,
                                Assets.logo,
                              ),
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Text(
                                'Zencillo Tanques permite la gestión eficiente de capacidades, estados y detalles técnicos de tanques',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: BlueStoneColors.blueStone700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                      const Text(
                        'Información',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _info(
                        Icon(
                          Icons.person_outline_outlined,
                          color: Colors.grey[700],
                        ),
                        'Nombre',
                        user.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _info(
                        Icon(
                          Icons.email_outlined,
                          color: Colors.grey[700],
                        ),
                        'Usuario/Correo',
                        user.login,
                      ),
                    ],
                  ),
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
                                      value:
                                          context.read<GetNotificationCubit>(),
                                    ),
                                    BlocProvider.value(
                                      value: context.read<GetUserAlertCubit>(),
                                    ),
                                    BlocProvider.value(
                                      value: context
                                          .read<GetUserNotificationCubit>(),
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
                            return const Column(
                              children: [
                                Text('Buscando notificaciones'),
                              ],
                            );
                          }
                          if (state.list.isNotEmpty) {
                            final listNoti = getNotiCubit.state.list;
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: state.list.map((item) {
                                final i = listNoti.firstWhereOrNull(
                                  (e) =>
                                      e.idNotificacion == item.idNotificacion,
                                );
                                return Chip(
                                  label: Text(
                                    i?.nombreNotificacion ?? '',
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Column(
                            children: [
                              Icon(
                                Icons.close_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No hay alertas configuradas',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
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
                            return const Column(
                              children: [
                                Text('Buscando Alertas'),
                              ],
                            );
                          }
                          if (state.list.isNotEmpty) {
                            final listAlerts = getAlertCubit.state.list;

                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: state.list.map((item) {
                                final i = listAlerts.firstWhereOrNull(
                                  (element) =>
                                      element.idAlerta == item.idAlerta,
                                );
                                return Chip(
                                  label: Text(
                                    i?.nombreAlerta ?? '',
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Column(
                            children: [
                              Icon(
                                Icons.close_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No hay alertas configuradas',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _info(Icon icon, String title, String text) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[700], fontSize: 15),
        ),
        const Spacer(),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}
