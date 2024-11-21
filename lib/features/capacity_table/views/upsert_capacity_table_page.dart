import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/view_icon_status.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/dialog_edit.dart';
import 'package:tanks_app/features/capacity_table/widgets/item_capacity_edit.dart';
import 'package:tanks_app/features/capacity_table/widgets/popup_menu_add.dart';
import 'package:tanks_app/features/tanks/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertCapacityTablePage extends StatelessWidget {
  const UpsertCapacityTablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CapacityTableCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<UpsertCapacityTableCubit>(),
        ),
      ],
      child: const UpsertCapacityTableView(),
    );
  }
}

class UpsertCapacityTableView extends StatelessWidget {
  const UpsertCapacityTableView({super.key});

  @override
  Widget build(BuildContext context) {
    final capacityTableCubit = context.read<CapacityTableCubit>();
    final tanksCubit = context.read<TanksCubit>();
    final upsertCapacityTableCubit = context.read<UpsertCapacityTableCubit>();
    return MultiBlocListener(
      listeners: [
        ListenerPro<UpsertCapacityTableCubit, UpsertCapacityTableState>()
            .listen(
          onPressedSuccess: () {
            context.pop();
            capacityTableCubit.getToTank(
              context.read<TanksCubit>().state.selected.idTanque,
            );
          },
        ),
        ListenerPro<CapacityTableCubit, CapacityTableState>().listen(),
        ListenerEvent<CapacityTableCubit, CapacityTableState>().event(
          onSuccess: () {
            upsertCapacityTableCubit.init(
              capacityTableCubit.state.capacityEntitys,
            );
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          final tankEntity = tanksCubit.state.selected;
          capacityTableCubit.getToTank(tankEntity.idTanque);
        },
        child: const UpsertCapacityTableBody(),
      ),
    );
  }
}

class UpsertCapacityTableBody extends StatelessWidget {
  const UpsertCapacityTableBody({super.key});

  @override
  Widget build(BuildContext context) {
    //final inherited = UpsertCapacityTableInherited.of(context);
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    final tanksCubit = context.read<TanksCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const [
          PopupMenuAdd(),
        ],
        title: const Text(
          'Tabla de aforo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          // height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<UpsertCapacityTableCubit,
                      UpsertCapacityTableState>(
                    builder: (context, state) {
                      final list = state.capacityEntitys;
                      if (list.isEmpty) {
                        return const Center(
                          child: ViewIconStatus(
                            text: 'No hay una tabla de aforo registrada.',
                            icon: Icon(Icons.warning_amber_outlined),
                          ),
                        );
                      }

                      return list.toListView(
                        isWrap: true,
                        itemBuilder: (k, item, q) {
                          return ItemCapacityEdit(
                            capacityTableEntity: item,
                            onTap: () {
                              upsertCapacityCubit.removeStagingItem(
                                item.idStaging,
                              );
                            },
                            onTapEdit: () {
                              upsertCapacityCubit.onSelectedEditItem(item);
                              showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: upsertCapacityCubit,
                                    child: const DialogEdit(),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonCustom(
                      onPressed: () {
                        context.pop();
                      },
                      text: 'Cancelar',
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonCustom(
                      onPressed: () {
                        upsertCapacityCubit.create(
                          idTanque: tanksCubit.state.selected.idTanque,
                        );
                      },
                      text: 'Guardar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
