import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/create_capacity_dialog.dart';
import 'package:tanks_app/injection/injection.dart';

class DetailTankView extends StatelessWidget {
  const DetailTankView({required this.tanksEntity, super.key});
  final TanksEntity tanksEntity;
  static Route<bool?> route({required TanksEntity tanksEntity}) {
    return MaterialPageRoute<bool?>(
      builder: (context) => DetailTankView(
        tanksEntity: tanksEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CapacityTableCubit>()
        ..getToTank(
          tanksEntity.idTanque,
        ),
      child: DetailTank(
        tanksEntity: tanksEntity,
      ),
    );
  }
}

class DetailTank extends StatelessWidget {
  const DetailTank({required this.tanksEntity, super.key});

  final TanksEntity tanksEntity;

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 243, 170, 25),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final capacityCubit = context.read<CapacityTableCubit>();
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Detalles del tanque'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDetailRow(
              'Sales Center ID:',
              tanksEntity.idCentroVenta.toString(),
              Icons.store_mall_directory_outlined,
            ),
            _buildDetailRow(
              'Capacity:',
              '${tanksEntity.capacidad} L',
              Icons.local_gas_station_outlined,
            ),
            _buildDetailRow(
              'Tank Height:',
              '${tanksEntity.alturaTanque} m',
              Icons.height_outlined,
            ),
            _buildDetailRow(
              'Description:',
              tanksEntity.descripcion,
              Icons.description_outlined,
            ),
            _buildDetailRow(
              'Min. Fuel Percentage:',
              '${tanksEntity.porcentajeMinimoCombustible}%',
              Icons.local_fire_department_outlined,
            ),
            _buildDetailRow(
              'Status:',
              tanksEntity.estado ? 'Active' : 'Inactive',
              Icons.power_settings_new_outlined,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lista de aforos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<bool?>(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return BlocProvider.value(
                          value: capacityCubit,
                          child: const CreateCapacityView(),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 170, 25),
                    padding: const EdgeInsets.symmetric(
                      //vertical: 15,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Añadir aforo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocSelector<CapacityTableCubit, CapacityTableState,
                    List<CapacityTableEntity>>(
                  selector: (state) => state.tanks,
                  builder: (c, s) {
                    return s.toListView(
                      itemBuilder: (k, l, q) {
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        l.alturaTanque.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Altura tanque',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                            255,
                                            126,
                                            126,
                                            126,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        l.volumen.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Volumen',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                            255,
                                            126,
                                            126,
                                            126,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
