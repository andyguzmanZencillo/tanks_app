import 'package:tank_api/core/extends/json_extends.dart';

class ArticleResponse {
  const ArticleResponse({
    required this.idArticulo,
    required this.idCompania,
    required this.articulo,
    required this.descripcion,
    required this.color,
    required this.precio,
    required this.code,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      idArticulo: json.get('id_articulo', 0),
      idCompania: json.get('id_compania', 0),
      articulo: json.get('articulo', ''),
      descripcion: json.get('descripcion', ''),
      color: json.get('color', ''),
      precio: json.get('precio', 0),
      code: json.get('codigo_articulo', ''),
    );
  }
  final int idArticulo;
  final int idCompania;
  final String articulo;
  final String descripcion;
  final String color;
  final double precio;
  final String code;
}
