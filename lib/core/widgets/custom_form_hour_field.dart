import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanks_app/core/util/extensions/extension_time_of_day.dart';

class DateFormater {
  static String formatTime(DateTime? date) {
    return date == null ? 'Sin Hora' : DateFormat('hh:mm:ss').format(date);
  }
}

class CustomFormHourField extends StatelessWidget {
  const CustomFormHourField({
    required this.label,
    required this.controller,
    super.key,
    this.onChanged,
    this.enabled = true,
    this.tooltip = '',
  });
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final void Function(TimeOfDay newValue)? onChanged;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    Future<void> selectTime() async {
      final pickedTime = await showTimePicker(
        context: context,
        hourLabelText: 'Hora',
        helpText: 'Seleccione la hora',
        minuteLabelText: 'Minuto',
        errorInvalidText: 'Tiempo invalido',
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (pickedTime == null) return;
      controller.text = pickedTime.formatTime();
    }

    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: () async {
        await selectTime();
      },
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(
          FluentIcons.calendar_20_regular,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        label: Text(
          label,
        ),
      ),
    );
  }
}
