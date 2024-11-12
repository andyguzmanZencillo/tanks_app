import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/sales_center/cubit/sales_center_cubit.dart';

class SalesCenterDeleteDialog extends StatelessWidget {
  const SalesCenterDeleteDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final salesCenterCubit = context.read<SalesCenterCubit>();
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirmar Eliminación',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Text(
              '¿Estás seguro de que deseas eliminar el siguiente centro de venta?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Correo: ${salesCenterCubit.state.selected.correo}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Descripción: ${salesCenterCubit.state.selected.descripcion}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ButtonCustom(
                    backgroundColor: const Color.fromARGB(255, 194, 194, 194),
                    onPressed: () {
                      context.pop();
                    },
                    text: 'Cancelar',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ButtonCustom(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      context.pop();
                      salesCenterCubit.delete(
                        salesCenterCubit.state.selected.idCentroVenta,
                      );
                    },
                    text: 'Eliminar',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
