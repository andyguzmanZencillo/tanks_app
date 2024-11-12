import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/field_capacity.dart';

class DialogSecuence extends StatelessWidget {
  const DialogSecuence({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerEscala = TextEditingController();
    final controllerIncremento = TextEditingController();
    final upsertCapacityCubit = context.read<UpsertCapacityTableCubit>();
    final globalKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Escala tabla de aforo'),
      content: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FieldCapacity(
                labelText: 'Escala',
                isInteger: true,
                controller: controllerEscala,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FieldCapacity(
                labelText: 'Incremento',
                controller: controllerIncremento,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
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
                        final valid = globalKey.currentState!.validate();
                        if (valid) {
                          upsertCapacityCubit.addSecuence(
                            controllerEscala.text.toIntSafe(),
                            controllerIncremento.text.toDoubleSafe(),
                          );
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
