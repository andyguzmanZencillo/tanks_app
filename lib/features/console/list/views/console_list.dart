import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';
import 'package:tanks_app/features/console/create_update/views/upsert_console_page.dart';
import 'package:tanks_app/features/console/delete/cubit/delete_console_cubit.dart';
import 'package:tanks_app/features/console/delete/helpers/delete_console_listener.dart';
import 'package:tanks_app/features/console/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/console/list/helpers/console_listener.dart';
import 'package:tanks_app/injection/injection.dart';

class ConsoleListPage extends StatelessWidget {
  const ConsoleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ConsoleCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DeleteConsoleCubit>(),
        ),
      ],
      child: const ConsoleListView(),
    );
  }
}

class ConsoleListView extends StatelessWidget {
  const ConsoleListView({super.key});

  @override
  Widget build(BuildContext context) {
    final consoleCubit = context.read<ConsoleCubit>();
    return MultiBlocListener(
      listeners: [
        ConsoleListener.console(),
        DeleteConsoleListener.delete(
          onTap: (p0) {
            consoleCubit.getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ConsoleCubit>().getAll();
        },
        onDispose: () {},
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
    final deleteCubit = context.read<DeleteConsoleCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consolas de tanque'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFieldCustomPro(
                    controller: ControllerField(),
                    label: 'Buscar...',
                    isLabelTitle: false,
                    onChanged: consoleCubit.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushContext(
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
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<ConsoleCubit, ConsoleState>(
                builder: (context, state) {
                  final list = state.list;
                  return list.toListView(
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
                                  BlocProvider.value(value: deleteCubit),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlueStoneColors.blueStone200,
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: BlueStoneColors.blueStone600,
          child: Icon(
            Icons.art_track,
            color: Colors.white,
          ),
        ),
        title: Text(
          consoleEntity.consola,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: BlueStoneColors.blueStone950,
          ),
        ),
        subtitle: Text(
          consoleEntity.descripcion,
          style: const TextStyle(
            color: BlueStoneColors.blueStone900,
          ),
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                onTap: onTapEdit,
                child: const Text('Editar'),
              ),
              PopupMenuItem(
                value: 'delete',
                onTap: onTapDelete,
                child: const Text('Eliminar'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
