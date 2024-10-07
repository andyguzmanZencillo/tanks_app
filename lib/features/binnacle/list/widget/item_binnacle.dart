import 'package:flutter/material.dart';
import 'package:tank_repository/features/binnacle/entity/binnacle_entity.dart';

class ItemBinnacle extends StatelessWidget {
  const ItemBinnacle({
    required this.binnacleEntity,
    super.key,
  });
  final BinnacleEntity binnacleEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        title: Text('N°: ${binnacleEntity.idBitacora}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hora incio Zeta: ${binnacleEntity.codigoTanque}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Hora fin Zeta: ${binnacleEntity.aguaAltura}',
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
