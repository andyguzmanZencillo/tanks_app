import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/capacity_table/entity/capacity_table_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/capacity_table/list/cubit/capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/widgets/form_capacity_inherited.dart';

class CreateCapacityView extends StatelessWidget {
  const CreateCapacityView({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCapacityInherited(child: const CreateCapacity());
  }
}

class CreateCapacity extends StatelessWidget {
  const CreateCapacity({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = FormCapacityInherited.of(context);
    final capacityCubit = context.read<CapacityTableCubit>();
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 170, 25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: capacityCubit.addStagingItem,
              ),
            ),
          ],
          title: const Text(
            'Lista de aforos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            // height: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: BlocSelector<CapacityTableCubit, CapacityTableState,
                      List<CapacityTableEntity>>(
                    selector: (state) {
                      return state.tanks;
                    },
                    builder: (context, state) {
                      for (final element in state) {
                        final cVolumen = inherited.getOrCreateVolumen(
                          element.idStaging,
                        );

                        final cAltura = inherited
                            .getOrCreateAlturaTanque(element.idStaging);

                        cVolumen.text = element.volumen.toString();
                        cAltura.text = element.alturaTanque.toString();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: BlocSelector<CapacityTableCubit,
                            CapacityTableState, List<CapacityTableEntity>>(
                          selector: (state) => state.tanksStaging,
                          builder: (c, s) {
                            return s.toListView(
                              isWrap: true,
                              itemBuilder: (k, item, q) {
                                final cVolumen = inherited.getOrCreateVolumen(
                                  item.idStaging,
                                );

                                final cAltura = inherited
                                    .getOrCreateAlturaTanque(item.idStaging);

                                return ItemCapacityEdit(
                                  capacityTableEntity: item,
                                  controllerAltura: cAltura,
                                  controllerVolumen: cVolumen,
                                  onTap: () {
                                    capacityCubit
                                        .removeStagingItem(item.idStaging);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ButtonCustom(
                  onPressed: () {},
                  text: 'Guardar Aforos',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCapacityEdit extends StatelessWidget {
  const ItemCapacityEdit({
    required this.capacityTableEntity,
    required this.controllerVolumen,
    required this.controllerAltura,
    required this.onTap,
    super.key,
  });
  final CapacityTableEntity capacityTableEntity;
  final TextEditingController controllerVolumen;
  final TextEditingController controllerAltura;
  final void Function() onTap;
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
                  CustomTextField(
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
                  CustomTextField(
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
            const SizedBox(
              width: 10,
            ),
            /*Container(
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
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 2,
            ),*/
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    );
  }
}
