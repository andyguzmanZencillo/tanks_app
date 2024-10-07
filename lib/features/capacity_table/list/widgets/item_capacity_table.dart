import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';

class ItemCapacitTableSimple extends StatelessWidget {
  const ItemCapacitTableSimple({required this.capacityEntity, super.key});
  final CapacityEntity capacityEntity;
  @override
  Widget build(BuildContext context) {
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
                    capacityEntity.alturaTanque.toString(),
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
                    capacityEntity.volumen.toString(),
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
  }
}
