import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/helpers/tank_variation_listener.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_page.dart';
import 'package:tanks_app/features/tanks/create_update/widgets/dropdown.dart';
import 'package:tanks_app/features/tanks/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/tanks/detail/views/detail_tank.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/list/helpers/list_tanks_listener.dart';
import 'package:tanks_app/features/tanks/widgets/item_tank.dart';
import 'package:tanks_app/injection/injection.dart';

class TanksListPage extends StatelessWidget {
  const TanksListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const TanksListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TanksCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SalesCenterCubit>(),
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
    return MultiBlocListener(
      listeners: [
        ListTanksListener.tanks(),
        TankVariationListener.salesCenter(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<SalesCenterCubit>().getAll();
        },
        onDispose: () {},
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
    final controllerDate = ControllerFieldDatePicker();
    final controllerDrp = ControllerFieldDropdown<SalesCenterEntity>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tanques',
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
                  child: BlocSelector<SalesCenterCubit, SalesCenterState,
                      List<SalesCenterEntity>>(
                    selector: (state) {
                      return state.list;
                    },
                    builder: (context, state) {
                      if (state.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return DropdownCustom(
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
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldCustomPro(
                    controller: ControllerField(),
                    label: 'Buscar...',
                    isLabelTitle: false,
                    onChanged: tanskCubit.search,
                  ),
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
            ),*/
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<TanksCubit, TanksState>(
                builder: (context, state) {
                  final list = state.list;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemTank(
                        tanksEntity: item,
                        onTap: () {
                          tanskCubit.changeSelected(item);
                          context.pushResult<bool?>(
                            DetailTankView.route(tanksCubit: tanskCubit),
                          );
                        },
                        onTapEdit: () {
                          tanskCubit.changeSelected(item);
                          context.pushContext(
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
                              child: DeleteTanksDialog(
                                consoleEntity: item,
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
