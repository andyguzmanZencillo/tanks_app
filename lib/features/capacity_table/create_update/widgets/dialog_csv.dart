import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';

class DialogCSV extends StatelessWidget {
  const DialogCSV({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    final notification = context.read<NotifyDialogHandlerCubit>();
    return AlertDialog(
      title: const Text('Importar CSV'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Importa tu tabla de aforo CSV separada por punto y coma (;)',
            ),
            const Text(
              '- Separador decimal ","',
            ),
            const Text('Ejemplo (CSV):'),
            const Text('230,501;5800,501'),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
            final value = textEditingController.text;
            if (value.isEmpty) return;
            final isValid = upsertCapacityCubit.validarFormatoCSV(value);
            if (!isValid) {
              notification.onNotification(
                const NotificationInfo(
                  NotificationType.error,
                  message: 'Formato CSV invalido',
                ),
              );
              return;
            }

            upsertCapacityCubit.addStagingItemCSV(value);

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
