import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    required this.idArticulo,
    required this.articulo,
    required this.descripcion,
    required this.color,
    required this.precio,
  });
  final int idArticulo;
  final String articulo;
  final String descripcion;
  final String color;
  final double precio;

  ArticleEntity copyWith({
    int? idArticulo,
    int? idCompania,
    String? articulo,
    String? descripcion,
    String? color,
    double? precio,
  }) {
    return ArticleEntity(
      idArticulo: idArticulo ?? this.idArticulo,
      articulo: articulo ?? this.articulo,
      descripcion: descripcion ?? this.descripcion,
      color: color ?? this.color,
      precio: precio ?? this.precio,
    );
  }

  @override
  List<Object?> get props => [
        idArticulo,
        articulo,
        descripcion,
        color,
        precio,
      ];
}
