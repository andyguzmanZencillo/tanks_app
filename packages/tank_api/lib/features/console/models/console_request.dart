import 'package:tank_api/features/company/company.dart';

class ConsoleRequest extends RequestBase {
  ConsoleRequest({super.query = 'FNZSTanques_crud_consola_tanques'});
}

class InsertConsoleRequest extends ConsoleRequest {
  InsertConsoleRequest({
    required this.idCompania,
    required this.console,
    required this.description,
    required this.idConsoleTankProtocol,
    required this.type,
    required this.ip,
    required this.socket,
    required this.portSerial,
    required this.passWordIp,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final String console;
  final String description;
  final int idConsoleTankProtocol;
  final String type;
  final String ip;
  final String socket;
  final String portSerial;
  final String passWordIp;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'consola': console,
      'descripcion': description,
      'id_consola_tanque_protocolo': idConsoleTankProtocol,
      'tipo': type,
      'ip': ip,
      'socket': socket,
      'puerto_serial': portSerial,
      'contrasena_ip': passWordIp,
    });
  }
}

class UpdateConsoleRequest extends ConsoleRequest {
  UpdateConsoleRequest({
    required this.idCompania,
    required this.idConsole,
    required this.console,
    required this.description,
    required this.idConsoleTankProtocol,
    required this.type,
    required this.ip,
    required this.socket,
    required this.portSerial,
    required this.passWordIp,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idConsole;
  final String console;
  final String description;
  final int idConsoleTankProtocol;
  final String type;
  final String ip;
  final String socket;
  final String portSerial;
  final String passWordIp;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_consola': idConsole,
      'id_compania': idCompania,
      'consola': console,
      'descripcion': description,
      'id_consola_tanque_protocolo': idConsoleTankProtocol,
      'tipo': type,
      'ip': ip,
      'socket': socket,
      'puerto_serial': portSerial,
      'contrasena_ip': passWordIp,
    });
  }
}

class GetConsoleRequest extends ConsoleRequest {
  GetConsoleRequest({
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

class DeleteConsoleRequest extends ConsoleRequest {
  DeleteConsoleRequest({
    required this.idConsole,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idConsole;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_consola': idConsole,
      'id_compania': idCompania,
    });
  }
}
