import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay? {
  String formatTime() {
    if (this == null) return '00:00:00';
    final hour = this!.hour;
    final minute = this!.minute;
    return this == null ? '00:00:00' : '$hour:$minute:00';
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');

    if (parts.length < 2) {
      throw const FormatException('Formato de hora no válido');
    }

    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
