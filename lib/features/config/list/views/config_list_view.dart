import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_page.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/helpers/tank_variation_listener.dart';
import 'package:tanks_app/features/tank_variation/list/widget/date_Picker.dart';
import 'package:tanks_app/features/tanks/create_update/widgets/dropdown.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class TankVariationListPage extends StatelessWidget {
  const TankVariationListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const TankVariationListPage(),
    );
  }

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
        BlocProvider(
          create: (context) => sl<TanksCubit>(),
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
        TankVariationListener.salesCenter(),
        TankVariationListener.tanks(),
        TankVariationListener.upsertTankVariation(),
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
    final controllerDrp = ControllerFieldDropdown<ValueExtend>();
    final cubit = context.read<TankVariationCubit>();
    final tankCubit = context.read<TanksCubit>();
    final notification = context.read<NotifyDialogHandlerCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Variación de tanques'),
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
                  child: BlocSelector<SalesCenterCubit, SalesCenterState,
                      List<SalesCenterEntity>>(
                    selector: (state) {
                      return state.salesCenters;
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
                  width: 110,
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
                SearchButton(
                  height: 64,
                  onPressed: () async {
                    if (controllerDate.getValue().isAfter(DateTime.now())) {
                      notification.onNotification(
                        const NotificationInfo(
                          NotificationType.error,
                          message:
                              'La fecha de busqueda no debe de superar la fecha actual.',
                        ),
                      );
                      return;
                    }
                    if (controllerDrp.getValue().id == 0) {
                      notification.onNotification(
                        const NotificationInfo(
                          NotificationType.error,
                          message: 'Seleccione un centro de venta.',
                        ),
                      );
                      return;
                    }
                    if (await tankCubit.getToSaleCenter(controllerDrp.id)) {
                      await cubit.getToSaleCenter(
                        controllerDrp.id,
                        controllerDate.getValue(),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocSelector<TanksCubit, TanksState, List<TanksEntity>>(
                selector: (state) {
                  return state.tanks;
                },
                builder: (context, tanks) {
                  return BlocSelector<TankVariationCubit, TankVariationState,
                      List<TankVariationEntity>>(
                    selector: (state) {
                      return state.consoles;
                    },
                    builder: (context, tanksVariation) {
                      return tanks.toListView(
                        itemSpacing: 10,
                        itemBuilder: (context, item, index) {
                          final tankVariation = tanksVariation.firstWhereOrNull(
                            (element) => element.idTanque == item.idTanque,
                          );
                          return ItemTankVariation(
                            tanksEntity: item,
                            consoleEntity: tankVariation,
                            onTapCreate: () {
                              tankCubit.changeSelected(item);
                              if (tankVariation != null) {
                                cubit.changeSelected(tankVariation);
                              }
                              context.pushResult(
                                UpsertTankVariationPage.route(
                                  tanksCubit: tankCubit,
                                  tankVariationCubit: cubit,
                                  typeOperation: TypeOperation.create,
                                ),
                              );
                            },
                            onTapUpdate: () {
                              tankCubit.changeSelected(item);
                              if (tankVariation != null) {
                                cubit.changeSelected(tankVariation);
                              }
                              context.pushResult(
                                UpsertTankVariationPage.route(
                                  tankVariationCubit: cubit,
                                  typeOperation: TypeOperation.update,
                                  tanksCubit: tankCubit,
                                ),
                              );
                            },
                            onTapDelete: () {},
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
    required this.onTapDelete,
    this.consoleEntity,
    super.key,
  });
  final TankVariationEntity? consoleEntity;
  final TanksEntity tanksEntity;
  final void Function() onTapCreate;
  final void Function() onTapUpdate;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    /*void actionPopUpItemSelected(
      String value,
      TankVariationEntity salesCenterEntity,
    ) {
      if (value == 'edit') {
        context
            .pushResult<bool?>(
          UpsertTankVariationPage.route(
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
            return DeleteTankVariationDialog(
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
*/
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
        title: Text(tanksEntity.text),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tanksEntity.descripcion,
            ),
            const SizedBox(
              height: 10,
            ),
            if (consoleEntity != null)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 113, 156, 73),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  'Variación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            if (consoleEntity == null)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 187, 76, 42),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  'Sin Variación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              if (consoleEntity != null)
                PopupMenuItem(
                  value: 'edit',
                  onTap: onTapUpdate,
                  child: const Text('Editar variación'),
                ),
              if (consoleEntity == null)
                PopupMenuItem(
                  value: 'new',
                  onTap: onTapCreate,
                  child: const Text('Crear variación'),
                ),
              PopupMenuItem(
                value: 'delete',
                onTap: onTapDelete,
                child: const Text('Eliminar'),
              ),
            ];
          },
          //onSelected: (v) => actionPopUpItemSelected(v, consoleEntity),
        ),
      ),
    );
  }
}
