import 'package:tank_api/core/extends/json_extends.dart';

class UserDeviceResponse {
  UserDeviceResponse({
    required this.token,
    required this.idUsuario,
    required this.dispositivo,
    required this.idCompania,
    required this.idUsuarioDispositivo,
  });

  factory UserDeviceResponse.fromJson(Map<String, dynamic> json) {
    return UserDeviceResponse(
      token: json.get('token', ''),
      idUsuario: json.get('id_usuario', 0),
      dispositivo: json.get('dispositivo', ''),
      idCompania: json.get('id_compania', 0),
      idUsuarioDispositivo: json.get('id_usuario_dispositivo', 0),
    );
  }
  final String token;
  final int idUsuario;
  final String dispositivo;
  final int idCompania;
  final int idUsuarioDispositivo;
}
