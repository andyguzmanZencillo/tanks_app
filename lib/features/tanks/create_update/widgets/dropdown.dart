import 'package:flutter/material.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({
    required this.items,
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
    this.hint,
    this.value,
    super.key,
  });

  final ValueExtend? value;
  final List<ValueExtend> items;
  final ControllerFieldDropdown<ValueExtend> controller;
  final String? Function(ValueExtend?) validator;
  final String label;
  final String? hint;
  final bool isLabelTitle;
  final bool showDecoration;

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  ValueExtend? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value; // Inicializar el valor seleccionado
    if (widget.value != null) {
      widget.controller.setValue(widget.value!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isLabelTitle)
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 5),
        DropdownButtonFormField<ValueExtend>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: widget.controller.fieldKey,
          focusNode: widget.controller.focusNode,
          validator: widget.validator,
          value: selectedValue, // Establece el valor seleccionado
          hint: Text(widget.hint ?? 'Seleccione un item'),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 233, 235, 236),
            hintText: widget.hint ?? 'Seleccione un item',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (ValueExtend? newValue) {
            setState(() {
              selectedValue = newValue;
              if (newValue != null) widget.controller.setValue(newValue);
            });
          },
          items: widget.items
              .map<DropdownMenuItem<ValueExtend>>((ValueExtend item) {
            return DropdownMenuItem<ValueExtend>(
              value: item,
              child: Text(item.text), // Muestra el valor del item
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DropdownItem {
  const DropdownItem({
    required this.value,
    required this.text,
  });

  final String value;
  final String text;
}

class DropdownTankItem<T> {
  const DropdownTankItem({
    required this.value,
    required this.text,
  });

  final T value;
  final String text;
}

class PosDropdown extends StatefulWidget {
  const PosDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.width,
    this.borderSide = const BorderSide(),
    super.key,
  });

  final String value;
  final List<DropdownItem> items;

  final void Function(String?) onChanged;

  final double? width;

  final BorderSide borderSide;

  @override
  State<PosDropdown> createState() => _PosDropdownState();
}

class _PosDropdownState extends State<PosDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: widget.borderSide,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            onChanged: (value) {
              widget.onChanged(value);
              FocusScope.of(context).nextFocus();
            },
            //value: widget.value.isNotEmpty ? widget.value : null,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            hint: const Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Seleccionar',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            items: widget.items.map((item) {
              return DropdownMenuItem<String>(
                value: item.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.text,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class TankDropdown<T> extends StatefulWidget {
  const TankDropdown({
    required this.items,
    required this.onChanged,
    this.value,
    this.width,
    this.borderSide = const BorderSide(),
    super.key,
  });

  final DropdownTankItem<T>? value;
  final List<DropdownTankItem<T>> items;

  final void Function(T?) onChanged;

  final double? width;

  final BorderSide borderSide;

  @override
  State<TankDropdown<T>> createState() => _TankDropdownState<T>();
}

class _TankDropdownState<T> extends State<TankDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: widget.borderSide,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DropdownTankItem<T>>(
            isExpanded: true,
            isDense: true,
            onChanged: (value) {
              widget.onChanged(value?.value);
              FocusScope.of(context).nextFocus();
            },
            value: widget.value,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            hint: const Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Seleccionar',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            items: widget.items.map((item) {
              return DropdownMenuItem<DropdownTankItem<T>>(
                value: item,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.text,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
