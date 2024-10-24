import 'package:tank_api/features/company/models/company_request.dart';

class UserDeviceRequest extends RequestBase {
  UserDeviceRequest({
    super.query = 'FNZSTanques_crud_usuario_dispositivo',
  });
}

class InsertUserDeviceRequest extends UserDeviceRequest {
  InsertUserDeviceRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.dispositivo,
    required this.token,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final String dispositivo;
  final String token;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'dispositivo': dispositivo,
      'token': token,
      'id_compania': idCompania,
    });
  }
}

class UpdateUserDeviceRequest extends UserDeviceRequest {
  UpdateUserDeviceRequest({
    required this.idCompania,
    required this.idUsuarioDispositivo,
    required this.idUsuario,
    required this.dispositivo,
    required this.token,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;
  final int idUsuarioDispositivo;
  final int idUsuario;
  final String dispositivo;
  final String token;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario_dispositivo': idUsuarioDispositivo,
      'id_usuario': idUsuario,
      'dispositivo': dispositivo,
      'token': token,
      'id_compania': idCompania,
    });
  }
}

class GetUserDeviceRequest extends UserDeviceRequest {
  GetUserDeviceRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.dispositivo,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;
  final int idUsuario;
  final String dispositivo;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_usuario': idUsuario,
      'dispositivo': dispositivo,
    });
  }
}
