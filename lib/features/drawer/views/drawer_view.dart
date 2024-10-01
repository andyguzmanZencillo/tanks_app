import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/drawer/cubit/drawer_cubit.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option_config.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerCubit>(
      create: (context) => DrawerCubit()
        ..onChangeOptions(
          OptionsConfig.options,
        ),
      child: const DrawerView(),
    );
  }
}

class DrawerView extends StatelessWidget {
  const DrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final drawerBloc = context.read<DrawerCubit>();

    return Container(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const InformationProfile(),
          const SizedBox(height: 10),
          //const InformationVersion(),
          Expanded(
            child: SizedBox(
              // width: context.width(.68),
              child: BlocSelector<DrawerCubit, DrawerState, List<Option>>(
                selector: (state) {
                  return state.listOption;
                },
                builder: (context, list) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final option = list[index];
                      return _DrawerButton(
                        onPressed: () async {
                          final route = option.route;
                          if (route != null && context.mounted) {
                            context.push(
                              MaterialPageRoute<void>(
                                builder: (context) => route,
                              ),
                            );
                          }

                          /*await launchUrl(
                            Uri.parse(
                              'https://zencillo.com/powered-by-zencillo/',
                            ),
                          );*/
                        },
                        title: option.name,
                        icon: option.icon,
                        isActive: option.isPermission,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1.5,
                        color: Colors.white.withOpacity(.05),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.isActive,
  });

  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive
          ? onPressed
          : () {
              ElegantNotification.error(
                title: const Text('Permiso Denegado'),
                description: const Text(
                  'No tienes permisos para acceder a esta opción...',
                ),
              ).show(context);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        surfaceTintColor: Colors.red,
        elevation: 0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Opacity(
              opacity: 0.6,
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              // fontSize: 17,
            ),
          ),
          if (!isActive) ...[
            const Spacer(),
            const Icon(
              Icons.lock,
              color: Colors.white,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}
