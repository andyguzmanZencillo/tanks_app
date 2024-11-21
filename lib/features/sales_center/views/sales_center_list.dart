import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
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
import 'package:tanks_app/features/sales_center/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/views/create_update_sales_center.dart.dart';
import 'package:tanks_app/features/sales_center/widgets/sales_center_delete_dialog.dart';
import 'package:tanks_app/injection/injection.dart';

class SalesCenterListPage extends StatelessWidget {
  const SalesCenterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SalesCenterCubit>()),
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
        ListenerPro<SalesCenterCubit, SalesCenterState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<SalesCenterCubit>().getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<SalesCenterCubit>().getAll();
        },
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldSearch(
                    extendTextField: ExtendTextField(
                      label: 'Buscar Centro de ventas...',
                    ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<SalesCenterCubit, SalesCenterState,
                    List<SalesCenterEntity>>(
                  selector: (state) => state.list,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          '${state.length} Centros de venta',
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
                          context.read<SalesCenterCubit>().changeSort(
                                Sort.asc,
                              );
                        },
                        child: const Text('Ascendente (A-Z)'),
                      ),
                      PopupMenuItem<void>(
                        onTap: () {
                          context.read<SalesCenterCubit>().changeSort(
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
                                ],
                                child: const SalesCenterDeleteDialog(),
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
                  Icons.shopping_basket_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  salesCenterEntity.centroVenta,
                  style: const TextStyle(
                    color: BlueStoneColors.blueStone900,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            salesCenterEntity.descripcion,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 15,
                      color: BlueStoneColors.blueStone700,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      salesCenterEntity.correo,
                      style:
                          const TextStyle(color: BlueStoneColors.blueStone900),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onTalEdit,
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
