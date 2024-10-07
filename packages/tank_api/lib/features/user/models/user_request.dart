import 'package:tank_api/features/company/company.dart';

class UserRequest extends RequestBase {
  UserRequest({
    super.query = 'FNZSTanques_crud_usuario',
  });
}

class InsertUserRequest extends UserRequest {
  InsertUserRequest({
    required this.idCompania,
    required this.nombre,
    required this.clave,
    required this.usuario,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;
  final String nombre;
  final String clave;
  final String usuario;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'nombre': nombre,
      'usuario': usuario,
      'clave': clave,
    });
  }
}

class UpdateUserRequest extends UserRequest {
  UpdateUserRequest({
    required this.idUsuario,
    required this.idCompania,
    required this.nombre,
    required this.clave,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idUsuario;
  final int idCompania;
  final String nombre;
  final String clave;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_compania': idCompania,
      'nombre': nombre,
      'clave': clave,
    });
  }
}

class SearchUserRequest extends UserRequest {
  SearchUserRequest({
    required this.idUsuario,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;
  final int idUsuario;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_compania': idCompania,
    });
  }
}

class DeletehUserRequest extends UserRequest {
  DeletehUserRequest({
    required this.idUsuario,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idUsuario;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_compania': idCompania,
    });
  }
}

class SignInUserRequest extends UserRequest {
  SignInUserRequest({
    required this.usuario,
    required this.clave,
    required this.idCompania,
    this.operation = 'S',
  });
  final String operation;
  final String usuario;
  final String clave;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'operation': operation,
      'id_compania': idCompania,
      'usuario': usuario,
      'clave': clave,
    });
  }
}
