import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/create_update/views/create_update_sales_center.dart.dart';
import 'package:tanks_app/features/sales_center/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class SalesCenterListPage extends StatelessWidget {
  const SalesCenterListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const SalesCenterListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SalesCenterCubit>()..getAll(),
      child: const SalesCenterListView(),
    );
  }
}

class SalesCenterListView extends StatelessWidget {
  const SalesCenterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros de ventas'),
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
                  UpsertSalesCenterPage.route(
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
                    'Crear Centro de venta',
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
              child: BlocBuilder<SalesCenterCubit, SalesCenterState>(
                builder: (context, state) {
                  final list = state.salesCenters;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemSalesCenter(
                        salesCenterEntity: item,
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

class ItemSalesCenter extends StatelessWidget {
  const ItemSalesCenter({required this.salesCenterEntity, super.key});
  final SalesCenterEntity salesCenterEntity;

  @override
  Widget build(BuildContext context) {
    void actionPopUpItemSelected(
      String value,
      SalesCenterEntity salesCenterEntity,
    ) {
      if (value == 'edit') {
        context
            .pushResult<bool?>(
          UpsertSalesCenterPage.route(
            typeOperation: TypeOperation.update,
            salesCenterEntity: salesCenterEntity,
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
            return DeleteSalesCenterDialog(
              salesCenterEntity: salesCenterEntity,
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
        title: Text(salesCenterEntity.centroVenta),
        subtitle: Text(
          salesCenterEntity.descripcion,
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
          onSelected: (v) => actionPopUpItemSelected(v, salesCenterEntity),
        ),
      ),
    );
  }
}
