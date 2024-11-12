import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/field_capacity.dart';

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
    final globalKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Editar item aforo'),
      content: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FieldCapacity(
                labelText: 'Altura',
                controller: textEditingAltura,
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
                labelText: 'Volumen',
                controller: textEditingVolumen,
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
                        if (globalKey.currentState!.validate()) {
                          upsertCapacityCubit.editStagingItem(
                            itemSelected.idStaging,
                            textEditingAltura.text,
                            textEditingVolumen.text,
                          );
                          context.pop();
                        }
                      },
                      text: 'Editar',
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
