import 'package:tank_api/core/extends/json_extends.dart'; // Asegúrate de tener esta extensión

class AlertResponse {
  const AlertResponse({
    required this.descripcion,
    required this.idCompania,
    required this.idAlerta,
    required this.nombreAlerta,
  });

  factory AlertResponse.fromJson(Map<String, dynamic> json) {
    return AlertResponse(
      descripcion: json.get<String>('descripcion', ''),
      idCompania: json.get<int>('id_compania', 0),
      idAlerta: json.get<int>('id_alerta', 0),
      nombreAlerta: json.get<String>(
        'nombre_alerta',
        '',
      ),
    );
  }

  final String descripcion;
  final int idCompania;
  final int idAlerta;
  final String nombreAlerta;
}
