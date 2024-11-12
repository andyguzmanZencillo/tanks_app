import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/helpers/user_device/helpers/user_device_listener.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/profile/alert/cubit/alert_cubit.dart';
import 'package:tanks_app/features/profile/information_profile/widgets/alert_notification.dart';
import 'package:tanks_app/features/profile/information_profile/widgets/config_devices.dart';
import 'package:tanks_app/features/profile/information_profile/widgets/info_general.dart';
import 'package:tanks_app/features/profile/information_profile/widgets/info_user.dart';
import 'package:tanks_app/features/profile/notification/notification_cubit.dart';
import 'package:tanks_app/features/profile/perfil/cubit/perfil_cubit.dart';
import 'package:tanks_app/features/profile/user_alert/user_alert_cubit.dart';
import 'package:tanks_app/features/profile/user_notification/notification_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class InformationProfilePage extends StatelessWidget {
  const InformationProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PerfilCubit>()),
        BlocProvider(create: (_) => sl<NotificationCubit>()),
        BlocProvider(create: (_) => sl<AlertCubit>()),
        BlocProvider(create: (_) => sl<UserAlertCubit>()),
        BlocProvider(create: (_) => sl<UserNotificationCubit>()),
        BlocProvider(create: (_) => sl<UserDeviceCubit>()),
      ],
      child: const InformationProfileView(),
    );
  }
}

class InformationProfileView extends StatelessWidget {
  const InformationProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilCubit = context.read<PerfilCubit>();
    return MultiBlocListener(
      listeners: [
        UserDeviceListener.userDevice(
          onTap: (s, o) {
            if (o == OperationType.delete && s == GeneralStatus.success) {
              context.read<UserDeviceCubit>().getAll();
            }
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () async {
          await perfilCubit.getInfo();
        },
        child: const InformationProfileBody(),
      ),
    );
  }
}

class InformationProfileBody extends StatelessWidget {
  const InformationProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                if (state.status == GeneralStatus.success) {
                  final user = state.user;
                  return Column(
                    children: [
                      InfoGeneral(userEntity: user),
                      InfoUser(user: user),
                    ],
                  );
                }

                return SizedBox.fromSize();
              },
            ),
            const AlertNotification(),
            const ConfigDevices(),
          ],
        ),
      ),
    );
  }
}
