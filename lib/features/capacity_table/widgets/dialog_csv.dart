import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/cubit/upsert_capacity_table_cubit.dart';

class DialogCSV extends StatelessWidget {
  const DialogCSV({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    final notification = context.read<NotifyDialogHandlerCubit>();
    final globalKey = GlobalKey<FormState>();

    return AlertDialog(
      title: const Text('Importar CSV'),
      content: SingleChildScrollView(
        child: Form(
          key: globalKey,
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
              TextFormField(
                controller: textEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: BlueStoneColors.blueStone700,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: BlueStoneColors.blueStone700,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ButtonCustom(
                      backgroundColor: const Color.fromARGB(255, 194, 194, 194),
                      onPressed: () {
                        context.pop();
                      },
                      text: 'Cerrar',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonCustom(
                      backgroundColor: BlueStoneColors.blueStone700,
                      onPressed: () {
                        final value = textEditingController.text;

                        final valid = globalKey.currentState!.validate();
                        if (valid) {
                          final isValid = upsertCapacityCubit.validarFormatoCSV(
                            value,
                          );
                          if (!isValid) {
                            ElegantNotification.error(
                              description:
                                  const Text('Formato invalido del CSV'),
                            ).show(context);
                            return;
                          }

                          upsertCapacityCubit.addStagingItemCSV(value);
                          context.pop();
                        }
                      },
                      text: 'Añadir',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
