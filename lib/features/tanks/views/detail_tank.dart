import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/views/upsert_capacity_table_page.dart';
import 'package:tanks_app/features/capacity_table/widgets/item_capacity_table.dart';
import 'package:tanks_app/features/tanks/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/widgets/detail_row.dart';
import 'package:tanks_app/injection/injection.dart';

class DetailTankPage extends StatelessWidget {
  const DetailTankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CapacityTableCubit>(),
      child: const DetailTankView(),
    );
  }
}

class DetailTankView extends StatelessWidget {
  const DetailTankView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<CapacityTableCubit, CapacityTableState>().listen(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          final tanksCubit = context.read<TanksCubit>();
          final tankEntity = tanksCubit.state.selected;
          context.read<CapacityTableCubit>().getToTank(tankEntity.idTanque);
        },
        child: const DetailTankBody(),
      ),
    );
  }
}

class DetailTankBody extends StatelessWidget {
  const DetailTankBody({super.key});

  @override
  Widget build(BuildContext context) {
    final capacityCubit = context.read<CapacityTableCubit>();
    final tanksCubit = context.read<TanksCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Detalles de tanque',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<TanksCubit, TanksState, TanksEntity>(
              selector: (state) => state.selected,
              builder: (c, tanksEntity) {
                return Column(
                  children: [
                    DetailRow(
                      'Descripción:',
                      tanksEntity.descripcion,
                      Icons.description_outlined,
                    ),
                    DetailRow(
                      'Capacidad:',
                      '${tanksEntity.capacidad} L',
                      Icons.local_gas_station_outlined,
                    ),
                    DetailRow(
                      'Altura tanque',
                      '${tanksEntity.alturaTanque} m',
                      Icons.height_outlined,
                    ),
                    DetailRow(
                      '% Min. de combustible:',
                      '${tanksEntity.porcentajeMinimoCombustible}%',
                      Icons.local_fire_department_outlined,
                    ),
                    DetailRow(
                      'Estado:',
                      tanksEntity.estado ? 'Activo' : 'Inactivo',
                      Icons.power_settings_new_outlined,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tabla de aforo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GenericButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet<bool?>(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: capacityCubit,
                                ),
                                BlocProvider.value(
                                  value: tanksCubit,
                                ),
                              ],
                              child: const UpsertCapacityTablePage(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocSelector<CapacityTableCubit, CapacityTableState,
                    List<CapacityEntity>>(
                  selector: (state) => state.capacityEntitys,
                  builder: (c, s) {
                    return s.toListViewItem(
                      itemBuilder: (item) {
                        return ItemCapacitTableSimple(
                          capacityEntity: item,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
