import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

/*
class DropdownSalesCenter extends StatefulWidget {
  const DropdownSalesCenter({
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
  State<DropdownSalesCenter> createState() => _DropdownSalesCenterState();
}

class _DropdownSalesCenterState extends State<DropdownSalesCenter> {
  ValueExtend? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
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
              child: Row(
                children: [
                  const Icon(
                    Icons.oil_barrel,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ), // Muestra el valor del item
            );
          }).toList(),
        ),
      ],
    );
  }
}
*/
/*class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    super.key,
  });
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}*/

class DropdownSalesCenter<T> extends StatefulWidget {
  const DropdownSalesCenter({
    required this.items,
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
    required this.onChanged,
    this.hint,
    this.value,
    super.key,
  });

  final ValueExtend<T>? value;
  final List<ValueExtend<T>> items;
  final ControllerFieldDropdown controller;
  final String? Function(ValueExtend<T>?) validator;
  final String label;
  final String? hint;
  final bool isLabelTitle;
  final bool showDecoration;
  final void Function(ValueExtend<T>) onChanged;

  @override
  State<DropdownSalesCenter<T>> createState() => _DropdownSalesCenterState();
}

class _DropdownSalesCenterState<T> extends State<DropdownSalesCenter<T>> {
  ValueExtend<T>? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton2<ValueExtend<T>>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.oil_barrel,
                  color: BlueStoneColors.blueStone700,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Seleccione un centro de venta',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 71, 71, 71),
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items.map((ValueExtend<T> item) {
              return DropdownMenuItem<ValueExtend<T>>(
                value: item,
                child: Row(
                  children: [
                    const Icon(
                      Icons.factory,
                      color: BlueStoneColors.blueStone600,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*const Text(
                          'Centro de venta',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                          ),
                        ),*/
                        Text(
                          item.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: BlueStoneColors.blueStone900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            value: selectedValue,
            onChanged: (ValueExtend<T>? newValue) {
              setState(() {
                selectedValue = newValue;
                if (newValue != null) {
                  widget.controller.setValue(newValue);
                  widget.onChanged(newValue);
                }
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 60,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black26),
                color: Colors.white,
              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromARGB(255, 233, 235, 236),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 60,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownTanks<T> extends StatefulWidget {
  const DropdownTanks({
    required this.items,
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
    required this.onChanged,
    this.hint,
    this.value,
    super.key,
  });

  final ValueExtend<T>? value;
  final List<ValueExtend<T>> items;
  final ControllerFieldDropdown controller;
  final String? Function(ValueExtend<T>?) validator;
  final String label;
  final String? hint;
  final bool isLabelTitle;
  final bool showDecoration;
  final void Function(ValueExtend<T>) onChanged;

  @override
  State<DropdownTanks<T>> createState() => _DropdownTanksState();
}

class _DropdownTanksState<T> extends State<DropdownTanks<T>> {
  ValueExtend<T>? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton2<ValueExtend<T>>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.oil_barrel,
                  color: BlueStoneColors.blueStone700,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Seleccione un tanque',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 71, 71, 71),
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items.map((ValueExtend<T> item) {
              return DropdownMenuItem<ValueExtend<T>>(
                value: item,
                child: Row(
                  children: [
                    const Icon(
                      Icons.oil_barrel,
                      color: BlueStoneColors.blueStone700,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*const Text(
                          'Centro de venta',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                          ),
                        ),*/
                        Text(
                          item.text,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            value: selectedValue,
            onChanged: (ValueExtend<T>? newValue) {
              setState(() {
                selectedValue = newValue;
                if (newValue != null) {
                  widget.controller.setValue(newValue);
                  widget.onChanged(newValue);
                }
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 60,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black26),
                color: Colors.white,
              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromARGB(255, 233, 235, 236),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 60,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}
