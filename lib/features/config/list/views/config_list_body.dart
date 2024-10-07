import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button/custom_elevate_button.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/config/create_update/views/upsert_config_page.dart';
import 'package:tanks_app/features/config/delete/widget/delete_config_dialog.dart';
import 'package:tanks_app/features/config/list/cubit/config_cubit.dart';
import 'package:tanks_app/features/config/list/helpers/config_listener.dart';
import 'package:tanks_app/features/config/list/widget/item_config.dart';
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
        ConfigListener.config(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ConfigCubit>().getAll();
        },
        onDispose: () {},
        child: const ConfigListBody(),
      ),
    );
  }
}

class ConfigListBody extends StatelessWidget {
  const ConfigListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConfigCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Configuraciones'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                        value: cubit,
                        child: const UpsertConfigPage(
                          typeOperation: TypeOperation.create,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocSelector<ConfigCubit, ConfigState, List<ConfigEntity>>(
                selector: (state) {
                  return state.configurations;
                },
                builder: (context, configurations) {
                  return configurations.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemConfig(
                        configEntity: item,
                        onTapEdit: () {
                          cubit.changeSelected(item);
                          showModalBottomSheet<bool?>(
                            context: context,
                            useSafeArea: true,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 250,
                                child: BlocProvider.value(
                                  value: cubit,
                                  child: const UpsertConfigPage(
                                    typeOperation: TypeOperation.update,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onTapDelete: () {
                          showDialog<bool>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteConfigDialog(
                                configEntity: item,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
