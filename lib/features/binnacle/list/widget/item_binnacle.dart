import 'package:flutter/material.dart';
import 'package:tank_repository/features/binnacle/entity/binnacle_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class ItemBinnacle extends StatelessWidget {
  const ItemBinnacle({
    required this.binnacleEntity,
    super.key,
  });
  final BinnacleEntity binnacleEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.show(
          DialogInfo(
            lectura: binnacleEntity,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: BlueStoneColors.blueStone200,
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: const CircleAvatar(
            backgroundColor: BlueStoneColors.blueStone900,
            child: Icon(
              Icons.oil_barrel,
              color: Colors.white,
            ),
          ),
          title: Text(
            'N°: ${binnacleEntity.idBitacora}',
            style: const TextStyle(color: BlueStoneColors.blueStone700),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha lectura: ${binnacleEntity.fechaLectura!.format()}',
              ),
              Text(
                'Saldo: ${binnacleEntity.saldo}',
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalle de Lectura'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Descripción'),
                subtitle: Text('Lectura inicial'),
              ),
              ListTile(
                title: Text('Código del Tanque'),
                subtitle: Text('CT-001'),
              ),
              ListTile(
                title: Text('Saldo'),
                subtitle: Text('500.0'),
              ),
              ListTile(
                title: Text('Agua'),
                subtitle: Text('10.0'),
              ),
              ListTile(
                title: Text('Descargue'),
                subtitle: Text('50.0'),
              ),
              ListTile(
                title: Text('Saldo Altura'),
                subtitle: Text('5.0'),
              ),
              ListTile(
                title: Text('Agua Altura'),
                subtitle: Text('0.5'),
              ),
              ListTile(
                title: Text('Volumen Real'),
                subtitle: Text('490.0'),
              ),
              ListTile(
                title: Text('Fecha de Lectura'),
                subtitle: Text('2024-09-20'),
              ),
              ListTile(
                title: Text('Hora'),
                subtitle: Text('08:00:00'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class DialogInfo extends StatelessWidget {
  const DialogInfo({required this.lectura, super.key});

  final BinnacleEntity lectura;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Detalle de Lectura'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Descripción: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.descripcion,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Código del Tanque: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.codigoTanque,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Saldo: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.saldo.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Agua: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.agua.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Descargue: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.descargue.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Saldo Altura: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.saldoAltura.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Agua Altura: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.aguaAltura.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Volumen Real: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.volumenReal.toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Fecha de Lectura: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.fechaLectura!.format(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Hora: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: lectura.hora,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
