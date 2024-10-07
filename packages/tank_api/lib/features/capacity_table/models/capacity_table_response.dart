import 'package:tank_api/core/extends/json_extends.dart';

/*class CapacityTableResponse {
  CapacityTableResponse({
    required this.idAforo,
    required this.data,
    required this.idCompania,
  });

  factory CapacityTableResponse.fromJson(Map<String, dynamic> json) {
    return CapacityTableResponse(
      idAforo: json.get('id_aforo', 0),
      idCompania: json.get('id_compania', 0),
      idTanque: json.get('id_tanque', 0),
      alturaTanque: json.get('altura_tanque', 0),
      data: json.get('volumen', []),
    );
  }
  final int idAforo;
  final int idCompania;
  final int idTanque;
  final List<CapacityResponse> data;
}*/

class CapacityResponse {
  CapacityResponse({
    required this.alturaTanque,
    required this.volumen,
    required this.idAforo,
  });

  factory CapacityResponse.fromJson(Map<String, dynamic> json) {
    return CapacityResponse(
      idAforo: json.get('id_aforo', 0),
      alturaTanque: json.get('altura_tanque', 0),
      volumen: json.get('volumen', 0),
    );
  }
  final int idAforo;
  final double alturaTanque;
  final double volumen;
}
