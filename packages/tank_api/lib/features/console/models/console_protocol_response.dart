import 'package:tank_api/core/extends/json_extends.dart';

class ConsoleProtocolResponse {
  const ConsoleProtocolResponse({
    required this.descripcion,
    required this.protocolo,
    required this.idConsolaProtocol,
  });

  factory ConsoleProtocolResponse.fromJson(Map<String, dynamic> json) {
    return ConsoleProtocolResponse(
      descripcion: json.get('descripcion', ''),
      protocolo: json.get('protocolo', ''),
      idConsolaProtocol: json.get('id_consola_tanque_protocolo', 0),
    );
  }
  final int idConsolaProtocol;

  final String protocolo;
  final String descripcion;
}
