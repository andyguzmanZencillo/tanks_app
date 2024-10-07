import 'package:tank_api/core/extends/json_extends.dart';

class ConfigResponse {
  ConfigResponse({
    required this.idCompania,
    required this.idConfiguracion,
    required this.horaInicioZeta,
    required this.horaFinZeta,
  });

  factory ConfigResponse.fromJson(Map<String, dynamic> json) {
    return ConfigResponse(
      idCompania: json.get('id_compania', 0),
      idConfiguracion: json.get('id_configuracion', 0),
      horaInicioZeta: json.get('hora_inicio_zeta', '00:00:00'),
      horaFinZeta: json.get('hora_fin_zeta', '00:00:00'),
    );
  }

  final int idCompania;
  final int idConfiguracion;
  final String horaInicioZeta;
  final String horaFinZeta;
}
