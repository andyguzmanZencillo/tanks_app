import 'package:tank_api/features/company/company.dart';

class ConsoleProtocolRequest extends RequestBase {
  ConsoleProtocolRequest({
    super.query = 'FNZSTanques_crud_consola_tanque_protocolo',
  });
}

class GetConsoleProtocolRequest extends ConsoleProtocolRequest {
  GetConsoleProtocolRequest({
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
    });
  }
}
