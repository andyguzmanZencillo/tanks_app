import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_multi_entity.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';
import 'package:tanks_app/features/sales_center/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_page.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/helpers/tank_variation_listener.dart';
import 'package:tanks_app/features/tank_variation/list/widget/date_Picker.dart';
import 'package:tanks_app/features/tanks/widgets/dropdown.dart';
import 'package:tanks_app/injection/injection.dart';

class TankVariationListPage extends StatelessWidget {
  const TankVariationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TankVariationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SalesCenterCubit>(),
        ),
      ],
      child: const TankVariationListView(),
    );
  }
}

class TankVariationListView extends StatelessWidget {
  const TankVariationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<SalesCenterCubit, SalesCenterState>().listen(),
        TankVariationListener.tankVariation(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<SalesCenterCubit>().getAll();
        },
        onDispose: () {},
        child: const TankVariationListBody(),
      ),
    );
  }
}

class TankVariationListBody extends StatelessWidget {
  const TankVariationListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerDate = ControllerFieldDatePicker();
    final controllerDrp = ControllerFieldDropdown<SalesCenterEntity>();
    final cubit = context.read<TankVariationCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Variación de tanques',
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
                SizedBox(
                  width: 100,
                  child: DatePickerCustom(
                    value: DateTime.now(),
                    label: 'Seleccione fecha',
                    hint: 'Seleccione una fecha',
                    controller: controllerDate,
                    validator: (value) {
                      if (value == null) return 'Debe seleccionar una fecha';

                      return null;
                    },
                    isLabelTitle: false,
                    showDecoration: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SearchButtonPro(
                  onPressed: () async {
                    if (controllerDate.getValue().isAfter(DateTime.now())) {
                      ElegantNotification.error(
                        description: const Text(
                          'La fecha de busqueda no debe de superar la fecha actual.',
                        ),
                      ).show(context);
                      cubit.clearList();
                      return;
                    }
                    if (controllerDrp.getValue().id == 0) {
                      ElegantNotification.error(
                        description: const Text(
                          'Seleccione un centro de venta.',
                        ),
                      ).show(context);
                      return;
                    }
                    cubit.changeDateSearch(
                      controllerDate.getValue().singleDate(),
                    );
                    await cubit.getBySaleCenterAndDatePro(
                      controllerDrp.id,
                      controllerDate.getValue().singleDate(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocSelector<TankVariationCubit, TankVariationState,
                  List<TankVariationMultiEntity>>(
                selector: (state) {
                  return state.listPro;
                },
                builder: (context, tanksVariation) {
                  return tanksVariation.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemTankVariation(
                        tanksEntity: item.tank,
                        isManual: item.tank.idConsolaTanque != 0,
                        consoleEntity: item.tankVariation.firstOrNull,
                        existVariation: item.tankVariation.isNotEmpty,
                        onTapCreate: () {
                          cubit.changeSelectedPro(item);
                          context.pushComplete(
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: cubit,
                                ),
                              ],
                              child: const UpsertTankVariationPage(
                                typeOperation: TypeOperation.create,
                              ),
                            ),
                          );
                        },
                        onTapUpdate: () {
                          cubit.changeSelectedPro(item);
                          context.pushComplete(
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: cubit,
                                ),
                              ],
                              child: const UpsertTankVariationPage(
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

class ItemTankVariation extends StatelessWidget {
  const ItemTankVariation({
    required this.tanksEntity,
    required this.onTapCreate,
    required this.onTapUpdate,
    required this.existVariation,
    required this.isManual,
    this.consoleEntity,
    super.key,
  });
  final TankVariationEntity? consoleEntity;
  final TanksEntity tanksEntity;
  final void Function() onTapCreate;
  final void Function() onTapUpdate;
  final bool existVariation;
  final bool isManual;

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
            Icons.oil_barrel_sharp,
            color: Colors.white,
          ),
        ),
        title: Text(
          tanksEntity.text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: BlueStoneColors.blueStone950,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tanksEntity.descripcion,
            ),
            if (isManual)
              Container(
                child: const Text(
                  'Modo Consola ',
                ),
              )
            else
              Container(
                child: const Text(
                  'Modo Manual',
                ),
              ),
            if (consoleEntity != null)
              Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                  color: BlueStoneColors.blueStone800,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Variación registrada',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.check_box_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            if (consoleEntity == null)
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Variación no registrada',
                      style: TextStyle(
                        color: Color.fromARGB(255, 161, 72, 56),
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.close_outlined,
                      color: Color.fromARGB(255, 161, 72, 56),
                    ),
                  ],
                ),
              ),
          ],
        ),
        isThreeLine: true,
        trailing: existVariation
            ? IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: onTapUpdate,
              )
            : IconButton(
                icon: const Icon(Icons.add_box_rounded),
                onPressed: onTapCreate,
              ),
      ),
    );
  }
}
