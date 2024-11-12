import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button/custom_elevate_button.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/config/cubit/config_cubit.dart';
import 'package:tanks_app/features/config/views/upsert_config_page.dart';
import 'package:tanks_app/features/config/widgets/item_config.dart';
import 'package:tanks_app/injection/injection.dart';

class ConfigListPage extends StatelessWidget {
  const ConfigListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const ConfigListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ConfigCubit>(),
        ),
      ],
      child: const ConfigListView(),
    );
  }
}

class ConfigListView extends StatelessWidget {
  const ConfigListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<ConfigCubit, ConfigState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<ConfigCubit>().getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ConfigCubit>().getAll();
        },
        child: const ConfigListBody(),
      ),
    );
  }
}

class ConfigListBody extends StatelessWidget {
  const ConfigListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final configCubit = context.read<ConfigCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocSelector<ConfigCubit, ConfigState, List<ConfigEntity>>(
          selector: (state) {
            return state.configurations;
          },
          builder: (context, configurations) {
            if (configurations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('No hay una configuración registrada'),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomElevateButton(
                      text: 'Añadir',
                      isFlexible: true,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet<bool?>(
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 250,
                              child: BlocProvider.value(
                                value: configCubit,
                                child: const UpsertConfigPage(
                                  typeOperation: TypeOperation.create,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            final item = configurations.first;
            return Center(
              child: ItemConfig(
                configEntity: item,
                onTapEdit: () {
                  configCubit.changeSelected(item);
                  showModalBottomSheet<bool?>(
                    context: context,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 250,
                        child: BlocProvider.value(
                          value: configCubit,
                          child: const UpsertConfigPage(
                            typeOperation: TypeOperation.update,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
