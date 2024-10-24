import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/drawer/cubit/drawer_cubit.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option_config.dart';
import 'package:tanks_app/features/session/session_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_page.dart';

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
    final sessionCubit = context.read<SessionCubit>();
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  bottom: 20,
                  right: 20,
                ),
                //color: const Color.fromARGB(255, 37, 37, 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: BlueStoneColors.blueStone700,
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sessionCubit.state.userEntity.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: BlueStoneColors.blueStone950,
                                ),
                              ),
                              Text(
                                sessionCubit.state.userEntity.login,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: BlueStoneColors.blueStone900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.close),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: SizedBox(
                        child: BlocSelector<DrawerCubit, DrawerState,
                            List<Option>>(
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
                                      context.pushComplete(
                                        route,
                                      );
                                    }
                                  },
                                  title: option.name,
                                  icon: option.icon,
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
                    _DrawerButton(
                      onPressed: () {
                        context.read<SessionCubit>().removeUser();
                        context.goComplete(const SignInPage());
                      },
                      title: 'Cerrar sesión',
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Versión 1.0.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.onPressed,
    required this.title,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Icon(
              icon,
              color: BlueStoneColors.blueStone600,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              // fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
