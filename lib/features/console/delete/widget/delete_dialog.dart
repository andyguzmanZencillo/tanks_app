import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/console/delete/cubit/delete_console_cubit.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';

class DeleteConsoleDialog extends StatelessWidget {
  const DeleteConsoleDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeleteConsoleCubit>();
    final listConsole = context.read<ConsoleCubit>();
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Confirmar Eliminación',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  '¿Estás seguro de que deseas eliminar la siguiente consola de tanque?',
                ),
                const SizedBox(height: 16),
                Text(
                  'Consola: ${listConsole.state.selected.consola}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Descripción: ${listConsole.state.selected.descripcion}'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonCustom(
                        backgroundColor:
                            const Color.fromARGB(255, 194, 194, 194),
                        onPressed: () {
                          context.pop();
                        },
                        text: 'Cancelar',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonCustom(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          context.pop();
                          cubit.delete(
                            listConsole.state.selected.idConsola,
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
        ],
      ),
    );
  }
}
