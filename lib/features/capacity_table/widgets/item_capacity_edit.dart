import 'package:flutter/material.dart';
import 'package:tank_repository/features/capacity_table/entity/capacity_table_entity.dart';

class ItemCapacityEdit extends StatelessWidget {
  const ItemCapacityEdit({
    required this.capacityTableEntity,
    //required this.controllerVolumen,
    //required this.controllerAltura,
    required this.onTap,
    required this.onTapEdit,
    super.key,
  });
  final CapacityEntity capacityTableEntity;
  //final TextEditingController controllerVolumen;
  //final TextEditingController controllerAltura;
  final void Function() onTap;
  final void Function() onTapEdit;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 241, 241, 241),
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
                    capacityTableEntity.alturaTanque.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  /*FieldCapacity(
                    controller: controllerAltura,
                    hintText: '0.0',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // Haz algo cuando cambie el texto
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),*/
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    capacityTableEntity.volumen.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  /*FieldCapacity(
                    controller: controllerVolumen,
                    hintText: '0.0',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // Haz algo cuando cambie el texto
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),*/
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
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: onTapEdit,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 232, 232, 233),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 232, 232, 233),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
