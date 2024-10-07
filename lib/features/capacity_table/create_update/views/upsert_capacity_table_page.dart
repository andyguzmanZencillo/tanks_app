import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/capacity_table/entity/capacity_table_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/helpers/upsert_capacity_table_listener.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/dialog_edit.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/item_capacity_edit.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/popup_menu_add.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertCapacityTablePage extends StatelessWidget {
  const UpsertCapacityTablePage({
    required this.capacityEntitys,
    super.key,
  });
  final List<CapacityEntity> capacityEntitys;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UpsertCapacityTableCubit>()
        ..init(
          capacityEntitys,
        ),
      child: const UpsertCapacityTableView(),
    );
  }
}

class UpsertCapacityTableView extends StatelessWidget {
  const UpsertCapacityTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        UpsertCapacityTableListener.upsertTankVariation(),
      ],
      child: const UpsertCapacityTableBody(),
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

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Scaffold(
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
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            // height: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: BlocSelector<UpsertCapacityTableCubit,
                        UpsertCapacityTableState, List<CapacityEntity>>(
                      selector: (state) => state.capacityEntitys,
                      builder: (c, s) {
                        return s.toListView(
                          isWrap: true,
                          itemBuilder: (k, item, q) {
                            /*final capacity = inherited.getOrCreateCapacity(
                              item.idStaging,
                            );*/

                            return ItemCapacityEdit(
                              capacityTableEntity: item,
                              //controllerAltura: capacity.altura,
                              //controllerVolumen: capacity.volumen,
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
                ButtonCustom(
                  onPressed: () {
                    upsertCapacityCubit.create(
                      idTanque: tanksCubit.state.tankSelected.idTanque,
                    );
                  },
                  text: 'Guardar Aforos',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
