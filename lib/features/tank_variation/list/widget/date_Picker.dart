import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class TestCustomDatePickerField extends FormField<DateTime> {
  TestCustomDatePickerField({
    required DateTime super.initialValue,
    required String labelText,
    required BuildContext context,
    super.key,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<DateTime> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: initialValue,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != state.value) {
                      state.didChange(picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: labelText,
                      errorText: state.hasError ? state.errorText : null,
                    ),
                    child: Text(
                      state.value != null
                          ? '${state.value!.day}/${state.value!.month}/${state.value!.year}'
                          : '',
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}

class DatePickerCustom extends StatefulWidget {
  const DatePickerCustom({
    required this.controller,
    required this.validator,
    required this.label,
    required this.isLabelTitle,
    required this.showDecoration,
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

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.value ?? DateTime.now(); // Inicializar el valor seleccionado
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelTitle) ...[
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
          ],
          Stack(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: widget.hint ?? 'Seleccione una fecha',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    errorText: widget.validator(selectedDate),
                  ),
                  child: Center(
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : widget.hint ?? 'Seleccione una fecha',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    required this.onPressed,
    required this.height,
    super.key,
  });

  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 170, 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
        ),
        padding: EdgeInsets.zero,
        fixedSize: Size(48, height),
      ),
      child: const Icon(
        Icons.search,
        color: Colors.white, // Color del icono
      ),
    );
  }
}
