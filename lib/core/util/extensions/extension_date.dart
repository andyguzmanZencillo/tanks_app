import 'package:intl/intl.dart';

extension ExtensionDateTime on DateTime {
  String format([String separator = '-']) {
    return DateFormat('dd${separator}MM${separator}yyyy').format(this);
  }

  String formatHour() {
    return DateFormat('HH:mm:ss').format(this);
  }

  String literal() {
    return DateFormat('dd MMM yyyy HH:mm', 'es').format(this);
  }

  String literalDate() {
    return DateFormat('dd MMM yyyy', 'es').format(this);
  }

  String full([String format = 'dd-MM-yyyy HH:mm:ss']) {
    return DateFormat(format).format(this);
  }

  String compressed([String format = 'ddMMyyyyHHmmss']) {
    return DateFormat(format).format(this);
  }

  int getDateAsNumber() {
    final before = DateTime(1800);
    final today = DateTime.now();
    return today.difference(before).inDays + 1;
  }

  int getTimeAsNumber(DateTime time) {
    final formattedTime = DateFormat('HH:mm:ss').format(time);
    final partes = formattedTime.split(':');
    final horas = int.parse(partes[0]);
    final minutos = int.parse(partes[1]);
    final segundos = int.parse(partes[2]);
    final duracion = Duration(
      hours: horas,
      minutes: minutos,
      seconds: segundos,
    );
    final milisegundos = duracion.inMilliseconds;
    final text = milisegundos.toString().substring(0, 7);
    return int.parse(text);
  }
}
