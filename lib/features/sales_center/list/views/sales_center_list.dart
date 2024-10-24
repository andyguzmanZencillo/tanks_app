import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';
import 'package:tanks_app/features/sales_center/create_update/views/create_update_sales_center.dart.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/sales_center/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/list/helpers/sales_center_listener.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SalesCenterCubit>()),
        BlocProvider(create: (context) => sl<DeleteSalesCenterCubit>()),
      ],
      child: const SalesCenterListView(),
    );
  }
}

class SalesCenterListView extends StatelessWidget {
  const SalesCenterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        SalesCenterListener.salesCenter(),
        SalesCenterDeleteListener.delete(
          onTap: (status) {
            if (status == DeleteStatus.success) {
              context.read<SalesCenterCubit>().getAll();
            }
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<SalesCenterCubit>().getAll();
        },
        onDispose: () {},
        child: const SalesCenterListBody(),
      ),
    );
  }
}

class SalesCenterListBody extends StatelessWidget {
  const SalesCenterListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final salesCenterCubit = context.read<SalesCenterCubit>();
    final deleteCubit = context.read<DeleteSalesCenterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centros de ventas',
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
              children: [
                Expanded(
                  child: TextFieldCustomPro(
                    controller: ControllerField(),
                    label: 'Buscar...',
                    isLabelTitle: false,
                    onChanged: salesCenterCubit.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushContext(
                      BlocProvider.value(
                        value: salesCenterCubit,
                        child: const UpsertSalesCenterPage(
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
            Expanded(
              child: BlocBuilder<SalesCenterCubit, SalesCenterState>(
                builder: (context, state) {
                  final list = state.list;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemSalesCenter(
                        salesCenterEntity: item,
                        onTapDelete: () {
                          salesCenterCubit.changeSelected(item);
                          showDialog<bool>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: salesCenterCubit,
                                  ),
                                  BlocProvider.value(
                                    value: deleteCubit,
                                  ),
                                ],
                                child: const DeleteSalesCenterDialog(),
                              );
                            },
                          );
                        },
                        onTalEdit: () {
                          salesCenterCubit.changeSelected(item);
                          context.pushContext(
                            BlocProvider.value(
                              value: salesCenterCubit,
                              child: const UpsertSalesCenterPage(
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

class ItemSalesCenter extends StatelessWidget {
  const ItemSalesCenter({
    required this.salesCenterEntity,
    required this.onTapDelete,
    required this.onTalEdit,
    super.key,
  });
  final SalesCenterEntity salesCenterEntity;
  final void Function() onTapDelete;
  final void Function() onTalEdit;

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
            Icons.shopping_basket_rounded,
            color: Colors.white,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              salesCenterEntity.centroVenta,
              style: const TextStyle(
                color: BlueStoneColors.blueStone900,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              salesCenterEntity.correo,
              style: const TextStyle(color: BlueStoneColors.blueStone900),
            ),
          ],
        ),
        subtitle: Text(
          salesCenterEntity.descripcion,
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                onTap: onTalEdit,
                child: const Text('Editar'),
              ),
              PopupMenuItem(
                onTap: onTapDelete,
                value: 'delete',
                child: const Text('Eliminar'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
