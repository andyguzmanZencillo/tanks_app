import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/console/create_update/views/upsert_console_page.dart';
import 'package:tanks_app/features/console/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class ConsoleListPage extends StatelessWidget {
  const ConsoleListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const ConsoleListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ConsoleCubit>()..getAll(),
      child: const ConsoleListView(),
    );
  }
}

class ConsoleListView extends StatelessWidget {
  const ConsoleListView({super.key});

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: () {
                context
                    .pushResult<bool?>(
                  UpsertConsolePage.route(
                    typeOperation: TypeOperation.create,
                  ),
                )
                    .then((value) {
                  if (value == null || value == false) {
                    return;
                  }
                  context.read<SalesCenterCubit>().getAll();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 170, 25),
                padding: const EdgeInsets.symmetric(
                  //vertical: 15,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Crear consola de tanque',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<ConsoleCubit, ConsoleState>(
                builder: (context, state) {
                  final list = state.consoles;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemConsole(
                        consoleEntity: item,
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
  const ItemConsole({required this.consoleEntity, super.key});
  final ConsoleEntity consoleEntity;

  @override
  Widget build(BuildContext context) {
    void actionPopUpItemSelected(
      String value,
      ConsoleEntity salesCenterEntity,
    ) {
      if (value == 'edit') {
        context
            .pushResult<bool?>(
          UpsertConsolePage.route(
            typeOperation: TypeOperation.update,
            consoleEntity: consoleEntity,
          ),
        )
            .then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<SalesCenterCubit>().getAll();
        });
      } else if (value == 'delete') {
        showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DeleteConsoleDialog(
              consoleEntity: salesCenterEntity,
            );
          },
        ).then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<SalesCenterCubit>().getAll();
        });
      } else {}
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.art_track,
            color: Colors.white,
          ),
        ),
        title: Text(consoleEntity.consola),
        subtitle: Text(
          consoleEntity.descripcion,
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Editar'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar'),
              ),
            ];
          },
          onSelected: (v) => actionPopUpItemSelected(v, consoleEntity),
        ),
      ),
    );
  }
}
