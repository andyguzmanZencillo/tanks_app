import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/capacity_table/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/tanks/cubit/prepare_tank_cubit.dart';
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
    final prepareTankCubit = context.read<PrepareTankCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detalles de tanque',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocSelector<TanksCubit, TanksState, TanksEntity>(
                selector: (state) => state.selected,
                builder: (c, tanksEntity) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BlueStoneColors.blueStone600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Información',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Descripción',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color.fromARGB(162, 0, 0, 0),
                              ),
                            ),
                            Text(
                              tanksEntity.descripcion,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Divider(
                              thickness: 1.5,
                              color: Color.fromARGB(255, 212, 212, 212),
                            ),
                            if (prepareTankCubit.state.selectedSalesCenter !=
                                null) ...[
                              const Text(
                                'Articulo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color.fromARGB(162, 0, 0, 0),
                                ),
                              ),
                              Text(
                                prepareTankCubit
                                    .state.selectedArticle!.articulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const Divider(
                                thickness: 1.5,
                                color: Color.fromARGB(255, 212, 212, 212),
                              ),
                            ],
                            if (prepareTankCubit.state.selectedSalesCenter !=
                                null) ...[
                              const Text(
                                'Centro de venta',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color.fromARGB(162, 0, 0, 0),
                                ),
                              ),
                              Text(
                                prepareTankCubit
                                    .state.selectedSalesCenter!.centroVenta,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const Divider(
                                thickness: 1.5,
                                color: Color.fromARGB(255, 212, 212, 212),
                              ),
                            ],
                            if (prepareTankCubit.state.selectedConsole !=
                                null) ...[
                              const Text(
                                'Consonsola',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color.fromARGB(162, 0, 0, 0),
                                ),
                              ),
                              Text(
                                prepareTankCubit.state.selectedConsole!.consola,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BlueStoneColors.blueStone600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Detalles',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
              /*Column(
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
              /*Expanded(
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
              ),*/
            ],
          ),*/
            ],
          ),
        ),
      ),
    );
  }
}
