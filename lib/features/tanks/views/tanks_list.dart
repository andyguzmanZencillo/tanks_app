import 'package:collection/collection.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/view_icon_status.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';
import 'package:tanks_app/features/capacity_table/views/upsert_capacity_table_page.dart';
import 'package:tanks_app/features/tanks/cubit/prepare_tank_cubit.dart';
import 'package:tanks_app/features/tanks/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/views/detail_tank.dart';
import 'package:tanks_app/features/tanks/views/upsert_tanks_page.dart';
import 'package:tanks_app/features/tanks/widgets/delete_dialog.dart';
import 'package:tanks_app/features/tanks/widgets/dropdown_pro.dart';
import 'package:tanks_app/features/tanks/widgets/item_tank.dart';
import 'package:tanks_app/injection/injection.dart';

class TanksListPage extends StatelessWidget {
  const TanksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TanksCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PrepareTankCubit>(),
        ),
      ],
      child: const TanksListView(),
    );
  }
}

class TanksListView extends StatelessWidget {
  const TanksListView({super.key});

  @override
  Widget build(BuildContext context) {
    final prepareTankCubit = context.read<PrepareTankCubit>();
    return MultiBlocListener(
      listeners: [
        ListenerPro<PrepareTankCubit, PrepareTankState>().listen(),
        ListenerPro<TanksCubit, TanksState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<TanksCubit>().getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: prepareTankCubit.prepareData,
        child: const TanksListBody(),
      ),
    );
  }
}

class TanksListBody extends StatelessWidget {
  const TanksListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tanskCubit = context.read<TanksCubit>();
    final prepareTankCubit = context.read<PrepareTankCubit>();
    final controllerDrp = ControllerFieldDropdown<SalesCenterEntity>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tanques',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
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
                  child: BlocSelector<PrepareTankCubit, PrepareTankState,
                      List<SalesCenterEntity>>(
                    selector: (state) {
                      return state.salesCenters;
                    },
                    builder: (context, state) {
                      if (state.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return DropdownCustomPro(
                        controller: controllerDrp,
                        validator: (p0) {
                          if (p0 == null) {
                            return 'Valor requerido';
                          }
                          return null;
                        },
                        label: 'Centro de venta',
                        hint: 'Centro de venta',
                        showDecoration: false,
                        isLabelTitle: false,
                        items: state,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SearchButtonPro(
                  onPressed: () {
                    if (controllerDrp.getValue().id == 0) {
                      ElegantNotification.error(
                        description: const Text(
                          'Seleccione un centro de venta.',
                        ),
                      ).show(context);
                      return;
                    }

                    context.read<TanksCubit>().getToSaleCenter(
                          controllerDrp.getValue().id,
                        );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushContext(
                      BlocProvider.value(
                        value: tanskCubit,
                        child: const UpsertTanksPage(
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
              child: BlocBuilder<TanksCubit, TanksState>(
                builder: (context, state) {
                  final list = state.list;
                  if (state.generalStatus == GeneralStatus.initial) {
                    return const Center(
                      child: ViewIconStatus(
                        text:
                            'Selecciona un centro de ventas para buscar tanques.',
                        icon: Icon(Icons.info_outline),
                      ),
                    );
                  } else if (list.isEmpty) {
                    return const Center(
                      child: ViewIconStatus(
                        text: 'No hay tanques en este centro de ventas.',
                        icon: Icon(Icons.warning_amber_outlined),
                      ),
                    );
                  }

                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      final console =
                          prepareTankCubit.state.consoles.firstWhereOrNull(
                        (e) => e.idConsola == item.idConsolaTanque,
                      );
                      final saleCenter =
                          prepareTankCubit.state.salesCenters.firstWhereOrNull(
                        (e) => e.idCentroVenta == item.idCentroVenta,
                      );
                      final article =
                          prepareTankCubit.state.articles.firstWhereOrNull(
                        (e) => e.idArticulo == item.idArticulo,
                      );
                      return ItemTank(
                        consoleEntity: console,
                        salesCenterEntity: saleCenter,
                        tanksEntity: item,
                        articleEntity: article,
                        onTable: () {
                          tanskCubit.changeSelected(item);
                          context.pushComplete(
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: tanskCubit,
                                ),
                              ],
                              child: const UpsertCapacityTablePage(),
                            ),
                          );
                        },
                        onTap: () {
                          tanskCubit.changeSelected(item);
                          prepareTankCubit.changeSelected(
                            article,
                            console,
                            saleCenter,
                          );
                          context.pushComplete(
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: tanskCubit,
                                ),
                                BlocProvider.value(
                                  value: prepareTankCubit,
                                ),
                              ],
                              child: const DetailTankPage(),
                            ),
                          );
                        },
                        onTapEdit: () {
                          tanskCubit.changeSelected(item);
                          context.pushComplete(
                            BlocProvider.value(
                              value: tanskCubit,
                              child: const UpsertTanksPage(
                                typeOperation: TypeOperation.update,
                              ),
                            ),
                          );
                        },
                        onTapDelete: () {
                          tanskCubit.changeSelected(item);
                          context.show(
                            BlocProvider.value(
                              value: tanskCubit,
                              child: const TankDeleteDialog(),
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
