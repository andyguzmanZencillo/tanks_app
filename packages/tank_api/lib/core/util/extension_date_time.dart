import 'package:intl/intl.dart';

extension ExtensionDateTime on DateTime {
  int getDateAsNumberDate() {
    final before = DateTime(1800);
    return difference(before).inDays + 1;
  }

  /* int getDateAsNumberDate(DateTime date) {
    final before = DateTime(1800);
    final today = date;
    final days = today.difference(before).inDays;
    return days + 1;
  }*/

  /*int getTimeAsNumber() {
    final today = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(today);
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
  }*/

  /*int getTimeAsNumberDate(DateTime date) {
    final today = date;
    final formattedTime = DateFormat('HH:mm:ss').format(today);
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
    //final text = milisegundos.toString().substring(0, 7);
    //final text = milisegundos.toString().padLeft(7, '0').substring(0, 7);
    var text = milisegundos;
    if (milisegundos.toString().length > 7) {
      text = int.parse(milisegundos.toString().substring(0, 7));
    }
    return text;
  }*/
  int getTimeAsNumberDate() {
    final today = this;
    final formattedTime = DateFormat('HH:mm:ss').format(today);
    final partes = formattedTime.split(':');
    final horas = int.parse(partes[0]);
    final minutos = int.parse(partes[1]);
    final segundos = int.parse(partes[2]);
    final duracion = Duration(
      hours: horas,
      minutes: minutos,
      seconds: segundos,
    );
    final centesimas = duracion.inMilliseconds ~/ 10;

    var text = centesimas;
    if (centesimas.toString().length > 7) {
      text = int.parse(centesimas.toString().substring(0, 7));
    }
    return text;
  }
}
