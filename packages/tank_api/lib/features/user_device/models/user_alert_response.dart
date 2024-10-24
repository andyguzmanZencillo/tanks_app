import 'package:tank_api/core/extends/json_extends.dart';

class UserAlertResponse {
  UserAlertResponse({
    required this.idAlerta,
    required this.idUsuario,
    required this.idCompania,
    required this.idUsuarioAlerta,
  });

  factory UserAlertResponse.fromJson(Map<String, dynamic> json) {
    return UserAlertResponse(
      idAlerta: json.get('id_alerta', 0),
      idUsuario: json.get('id_usuario', 0),
      idCompania: json.get('id_compania', 0),
      idUsuarioAlerta: json.get('id_usuario_alerta', 0),
    );
  }
  final int idAlerta;
  final int idUsuario;
  final int idCompania;
  final int idUsuarioAlerta;

  Map<String, dynamic> toJson() {
    return {
      'id_alerta': idAlerta,
      'id_usuario': idUsuario,
      'id_compania': idCompania,
      'id_usuario_alerta': idUsuarioAlerta,
    };
  }
}
