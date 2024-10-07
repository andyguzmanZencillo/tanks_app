import 'package:tank_api/core/extends/json_extends.dart';

class UserResponse {
  UserResponse({
    required this.idCompania,
    required this.idUsuario,
    required this.nombre,
    required this.clave,
    required this.usuario,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      idUsuario: json.get('id_usuario', 0),
      idCompania: json.get('id_compania', 0),
      nombre: json.get('nombre', ''),
      clave: json.get('clave', ''),
      usuario: json.get('usuario', ''),
    );
  }
  final int idUsuario;
  final int idCompania;
  final String nombre;
  final String clave;
  final String usuario;
}
