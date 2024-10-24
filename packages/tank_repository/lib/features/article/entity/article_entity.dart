import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';

class ArticleEntity extends Equatable implements ValueExtend<ArticleEntity> {
  const ArticleEntity({
    required this.idArticulo,
    required this.articulo,
    required this.descripcion,
    required this.color,
    required this.precio,
    required this.code,
  });
  const ArticleEntity.empty()
      : idArticulo = 0,
        articulo = '',
        descripcion = '',
        color = '',
        precio = 0.0,
        code = '';

  final int idArticulo;
  final String articulo;
  final String descripcion;
  final String color;
  final double precio;
  final String code;

  ArticleEntity copyWith({
    int? idArticulo,
    int? idCompania,
    String? articulo,
    String? descripcion,
    String? color,
    double? precio,
    String? code,
  }) {
    return ArticleEntity(
      idArticulo: idArticulo ?? this.idArticulo,
      articulo: articulo ?? this.articulo,
      descripcion: descripcion ?? this.descripcion,
      color: color ?? this.color,
      precio: precio ?? this.precio,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [
        idArticulo,
        articulo,
        descripcion,
        color,
        precio,
        code,
      ];

  @override
  // TODO: implement text
  String get text => articulo;

  @override
  // TODO: implement value
  int get id => idArticulo;

  @override
  // TODO: implement value
  ArticleEntity? get value => this;
}
