import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/capacity_table/create_update/views/upsert_capacity_table_page.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/item_capacity_table.dart';
import 'package:tanks_app/injection/injection.dart';

class CapacityTableListPage extends StatelessWidget {
  const CapacityTableListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const CapacityTableListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CapacityTableCubit>()..getAll(),
      child: const CapacityTableListView(),
    );
  }
}

class CapacityTableListView extends StatelessWidget {
  const CapacityTableListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanques'),
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
                  UpsertCapacityTablePage.route(
                    typeOperation: TypeOperation.create,
                  ),
                )
                    .then((value) {
                  if (value == null || value == false) {
                    return;
                  }
                  context.read<CapacityTableCubit>().getAll();
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
                    'Crear tanque',
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
              child: BlocBuilder<CapacityTableCubit, CapacityTableState>(
                builder: (context, state) {
                  final list = state.tanks;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemCapacityTable(
                        tanksEntity: item,
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
