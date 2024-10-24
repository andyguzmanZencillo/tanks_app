import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class DatePickerHome extends StatefulWidget {
  const DatePickerHome({
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
    required this.title,
    this.hint,
    this.value,
    super.key,
  });

  final DateTime? value;
  final ControllerFieldDatePicker controller;
  final String? Function(DateTime?) validator;
  final String label;
  final String? hint;
  final bool isLabelTitle;
  final bool showDecoration;
  final String title;

  @override
  State<DatePickerHome> createState() => _DatePickerHomeState();
}

class _DatePickerHomeState extends State<DatePickerHome> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.value ?? DateTime.now();
    if (widget.value != null) {
      widget.controller.setValue(widget.value!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: 'Seleccione una fecha',
      confirmText: 'Seleccionar',
      cancelText: 'Cancelar',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      errorFormatText: 'Formato de fecha invalido',
      fieldLabelText: 'Fecha',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller.setValue(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color.fromARGB(57, 0, 0, 0),
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: 35,
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        hintText: widget.hint ?? 'Seleccione una fecha',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        errorText: widget.validator(selectedDate),
                      ),
                      child: Text(
                        selectedDate != null
                            ? selectedDate!.literalDate()
                            : widget.hint ?? 'Seleccione una fecha',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.calendar_month),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
