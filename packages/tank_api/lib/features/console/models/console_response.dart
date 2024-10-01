import 'package:tank_api/core/extends/json_extends.dart';

class ConsoleResponse {
  const ConsoleResponse({
    required this.idConsola,
    required this.idCompania,
    required this.consola,
    required this.descripcion,
    required this.idConsolaTanqueProtocolo,
    required this.tipo,
    required this.ip,
    required this.socket,
    required this.puertoSerial,
    required this.contrasenaIp,
  });

  factory ConsoleResponse.fromJson(Map<String, dynamic> json) {
    return ConsoleResponse(
      idConsola: json.get('id_consola', 0),
      idCompania: json.get('id_compania', 0),
      consola: json.get('consola', ''),
      descripcion: json.get('descripcion', ''),
      idConsolaTanqueProtocolo: json.get('id_consola_tanque_protocolo', 0),
      tipo: json.get('tipo', ''),
      ip: json.get('ip', ''),
      socket: json.get('socket', ''),
      puertoSerial: json.get('puerto_serial', ''),
      contrasenaIp: json.get('contrasena_ip', ''),
    );
  }
  final int idConsola;
  final int idCompania;
  final String consola;
  final String descripcion;
  final int idConsolaTanqueProtocolo;
  final String tipo;
  final String ip;
  final String socket;
  final String puertoSerial;
  final String contrasenaIp;
}
