import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_search.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';
import 'package:tanks_app/features/console/cubit/console_cubit.dart';
import 'package:tanks_app/features/console/views/upsert_console_page.dart';
import 'package:tanks_app/features/console/widgets/delete_dialog.dart';
import 'package:tanks_app/injection/injection.dart';

class ConsoleListPage extends StatelessWidget {
  const ConsoleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ConsoleCubit>()),
      ],
      child: const ConsoleListView(),
    );
  }
}

class ConsoleListView extends StatelessWidget {
  const ConsoleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<ConsoleCubit, ConsoleState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<ConsoleCubit>().getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ConsoleCubit>().getAll();
        },
        child: const ConsoleListBody(),
      ),
    );
  }
}

class ConsoleListBody extends StatelessWidget {
  const ConsoleListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final consoleCubit = context.read<ConsoleCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consolas de tanques',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldSearch(
                    extendTextField: ExtendTextField(
                      label: 'Buscar consola...',
                    ),
                    onChanged: consoleCubit.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushComplete(
                      BlocProvider.value(
                        value: consoleCubit,
                        child: const UpsertConsolePage(
                          typeOperation: TypeOperation.create,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<ConsoleCubit, ConsoleState, List<ConsoleEntity>>(
                  selector: (state) => state.list,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          '${state.length} consolas',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  },
                ),
                PopupMenuButton(
                  icon: Icon(
                    color: Colors.grey[700],
                    FluentIcons.arrow_sort_16_regular,
                    size: 20,
                    weight: 10,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<void>(
                        onTap: () {
                          context.read<ConsoleCubit>().changeSort(
                                Sort.asc,
                              );
                        },
                        child: const Text('Ascendente (A-Z)'),
                      ),
                      PopupMenuItem<void>(
                        onTap: () {
                          context.read<ConsoleCubit>().changeSort(
                                Sort.desc,
                              );
                        },
                        child: const Text('Descendente (Z-A)'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ConsoleCubit, ConsoleState>(
                builder: (context, state) {
                  final list = state.list;
                  return RefreshIndicator(
                    onRefresh: () {
                      return context.read<ConsoleCubit>().getAll();
                    },
                    child: list.toListView(
                      itemSpacing: 10,
                      itemBuilder: (context, item, index) {
                        return ItemConsole(
                          consoleEntity: item,
                          onTapDelete: () {
                            consoleCubit.onChangedSelected(item);
                            showDialog<bool>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: consoleCubit),
                                  ],
                                  child: const DeleteConsoleDialog(),
                                );
                              },
                            );
                          },
                          onTapEdit: () {
                            consoleCubit.onChangedSelected(item);
                            context.pushContext(
                              BlocProvider.value(
                                value: consoleCubit,
                                child: const UpsertConsolePage(
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
          ],
        ),
      ),
    );
  }
}

class ItemConsole extends StatelessWidget {
  const ItemConsole({
    required this.consoleEntity,
    required this.onTapEdit,
    required this.onTapDelete,
    super.key,
  });
  final ConsoleEntity consoleEntity;
  final void Function() onTapEdit;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(23, 187, 187, 187),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(87, 158, 158, 158),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: BlueStoneColors.blueStone600,
                child: Icon(
                  Icons.monitor,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            consoleEntity.consola,
                            style: const TextStyle(
                              color: BlueStoneColors.blueStone900,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: BlueStoneColors.blueStone150,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.vpn_key_rounded,
                                size: 18,
                                weight: 1,
                                color: BlueStoneColors.blueStone600,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                consoleEntity.tipo,
                                style: const TextStyle(
                                  color: BlueStoneColors.blueStone800,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.network_check,
                          size: 18,
                          color: BlueStoneColors.blueStone950,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          consoleEntity.ip.toString(),
                          style: const TextStyle(
                            color: BlueStoneColors.blueStone800,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.router,
                          size: 18,
                          color: BlueStoneColors.blueStone950,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          consoleEntity.socket,
                          style: const TextStyle(
                            color: BlueStoneColors.blueStone800,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      consoleEntity.descripcion,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onTapEdit,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: BlueStoneColors.blueStone700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: onTapDelete,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
