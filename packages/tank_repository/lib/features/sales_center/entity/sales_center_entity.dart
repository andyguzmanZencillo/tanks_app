import 'package:equatable/equatable.dart';

class ValueExtend<T> {
  const ValueExtend({
    this.id = 0,
    this.text = '',
    this.value,
  });

  final int id;
  final String text;
  final T? value;
}

class SalesCenterEntity extends Equatable
    implements ValueExtend<SalesCenterEntity> {
  const SalesCenterEntity({
    required this.idCentroVenta,
    required this.idCompania,
    required this.centroVenta,
    required this.descripcion,
    required this.correo,
  });

  const SalesCenterEntity.empty()
      : idCentroVenta = 0,
        idCompania = 0,
        centroVenta = '',
        descripcion = '',
        correo = '';

  final int idCentroVenta;
  final int idCompania;
  final String centroVenta;
  final String descripcion;
  final String correo;

  SalesCenterEntity copyWith({
    int? idCentroVenta,
    int? idCompania,
    String? centroVenta,
    String? descripcion,
    String? correo,
  }) {
    return SalesCenterEntity(
      idCentroVenta: idCentroVenta ?? this.idCentroVenta,
      idCompania: idCompania ?? this.idCompania,
      centroVenta: centroVenta ?? this.centroVenta,
      descripcion: descripcion ?? this.descripcion,
      correo: correo ?? this.correo,
    );
  }

  @override
  List<Object?> get props => [
        idCentroVenta,
        idCompania,
        centroVenta,
        descripcion,
        correo,
      ];

  @override
  String get text => centroVenta;

  @override
  int get id => idCentroVenta;

  @override
  SalesCenterEntity get value => this;
}
