import 'package:flutter/material.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class DropdownCustomPro<T> extends StatefulWidget {
  const DropdownCustomPro({
    required this.items,
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
    this.hint,
    this.title,
    this.value,
    super.key,
  });

  final ValueExtend<T>? value;
  final List<ValueExtend<T>> items;
  final ControllerFieldDropdown<T> controller;
  final String? Function(ValueExtend<T>?) validator;
  final String label;
  final String? hint;
  final bool isLabelTitle;
  final bool showDecoration;
  final String? title;

  @override
  State<DropdownCustomPro<T>> createState() => _DropdownCustomProState();
}

class _DropdownCustomProState<T> extends State<DropdownCustomPro<T>> {
  ValueExtend<T>? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    if (widget.value != null) {
      widget.controller.setValue(widget.value!);
    }
  }

  OutlineInputBorder style() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Color.fromARGB(59, 0, 0, 0),
        width: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelTitle || widget.title != null) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.title ?? widget.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          SizedBox(
            child: DropdownButtonFormField<ValueExtend<T>>(
              isExpanded: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: widget.controller.fieldKey,
              focusNode: widget.controller.focusNode,
              validator: widget.validator,
              value: selectedValue, // Establece el valor seleccionado
              hint: Text(
                widget.hint ?? 'Seleccione un item',
                style: const TextStyle(
                  color: Color.fromARGB(255, 141, 141, 141),
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.all(10),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                enabledBorder: style(),
                focusedBorder: style(),
                errorBorder: style(),
                focusedErrorBorder: style(),
              ),
              onChanged: (ValueExtend<T>? newValue) {
                setState(() {
                  selectedValue = newValue;
                  if (newValue != null) {
                    widget.controller.setValue(newValue);
                  }
                });
              },
              items: widget.items
                  .map<DropdownMenuItem<ValueExtend<T>>>((ValueExtend<T> item) {
                return DropdownMenuItem<ValueExtend<T>>(
                  value: item,
                  child: Text(
                    item.text,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ), // Muestra el valor del item
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
