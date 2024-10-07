import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/widgets/field_capacity.dart';

class DialogEdit extends StatelessWidget {
  const DialogEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingAltura = TextEditingController();
    final textEditingVolumen = TextEditingController();
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    final itemSelected = upsertCapacityCubit.state.selectedEditCapacity;
    textEditingAltura.text = itemSelected.alturaTanque.toString();
    textEditingVolumen.text = itemSelected.volumen.toString();
    return AlertDialog(
      title: const Text('Editar item aforo'),
      content: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FieldCapacity(
                labelText: 'Altura',
                controller: textEditingAltura,
                hintText: '0.0',
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FieldCapacity(
                labelText: 'Volumen',
                controller: textEditingVolumen,
                hintText: '0.0',
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.grey, width: 2),
            shape: const RoundedRectangleBorder(),
            backgroundColor: Colors.grey[200],
          ),
          child: const Text('Cerrar'),
        ),
        TextButton(
          onPressed: () {
            if (textEditingAltura.text.isNotEmpty &&
                textEditingVolumen.text.isNotEmpty) {
              upsertCapacityCubit.editStagingItem(
                itemSelected.idStaging,
                textEditingAltura.text,
                textEditingVolumen.text,
              );
            }
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(
              color: Color.fromARGB(255, 243, 170, 25),
              width: 2,
            ), // Borde azul
            shape: const RoundedRectangleBorder(),
            backgroundColor: const Color.fromARGB(255, 243, 170, 25),
          ),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
