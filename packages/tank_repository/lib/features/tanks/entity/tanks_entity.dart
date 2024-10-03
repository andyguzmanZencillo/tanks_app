import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';

class TanksEntity extends Equatable implements ValueExtend {
  const TanksEntity({
    required this.idTanque,
    required this.idCompania,
    required this.idCentroVenta,
    required this.idArticulo,
    required this.capacidad,
    required this.alturaTanque,
    required this.descripcion,
    required this.porcentajeMinimoCombustible,
    required this.alturaOffset,
    required this.factorInicioDescargue,
    required this.codigo,
    required this.alturaAguaOffset,
    required this.offsetInclinacion,
    required this.estado,
    required this.modificable,
    required this.manejaMm,
    required this.idConsolaTanque,
  });

  const TanksEntity.empty()
      : idTanque = 0,
        idCompania = 0,
        idCentroVenta = 0,
        idArticulo = 0,
        idConsolaTanque = 0,
        capacidad = 0,
        alturaTanque = 0.0,
        descripcion = '',
        porcentajeMinimoCombustible = 0,
        alturaOffset = 0.0,
        factorInicioDescargue = 0.0,
        codigo = 0,
        alturaAguaOffset = 0.0,
        offsetInclinacion = 0.0,
        estado = false,
        modificable = false,
        manejaMm = false;

  final int idTanque;
  final int idCompania;
  final int idCentroVenta;
  final int idArticulo;
  final int idConsolaTanque; // Puede ser nulo
  final double capacidad;
  final double alturaTanque;
  final String descripcion;
  final double porcentajeMinimoCombustible;
  final double alturaOffset;
  final double factorInicioDescargue;
  final int codigo;
  final double alturaAguaOffset;
  final double offsetInclinacion;
  final bool estado;
  final bool modificable;
  final bool manejaMm;

  TanksEntity copyWith({
    int? idTanque,
    int? idCompania,
    int? idCentroVenta,
    int? idArticulo,
    int? idConsolaTanque,
    double? capacidad,
    double? alturaTanque,
    String? descripcion,
    double? porcentajeMinimoCombustible,
    double? alturaOffset,
    double? factorInicioDescargue,
    int? codigo,
    double? alturaAguaOffset,
    double? offsetInclinacion,
    bool? estado,
    bool? modificable,
    bool? manejaMm,
  }) {
    return TanksEntity(
      idTanque: idTanque ?? this.idTanque,
      idCompania: idCompania ?? this.idCompania,
      idCentroVenta: idCentroVenta ?? this.idCentroVenta,
      idArticulo: idArticulo ?? this.idArticulo,
      idConsolaTanque: idConsolaTanque ?? this.idConsolaTanque,
      capacidad: capacidad ?? this.capacidad,
      alturaTanque: alturaTanque ?? this.alturaTanque,
      descripcion: descripcion ?? this.descripcion,
      porcentajeMinimoCombustible:
          porcentajeMinimoCombustible ?? this.porcentajeMinimoCombustible,
      alturaOffset: alturaOffset ?? this.alturaOffset,
      factorInicioDescargue:
          factorInicioDescargue ?? this.factorInicioDescargue,
      codigo: codigo ?? this.codigo,
      alturaAguaOffset: alturaAguaOffset ?? this.alturaAguaOffset,
      offsetInclinacion: offsetInclinacion ?? this.offsetInclinacion,
      estado: estado ?? this.estado,
      modificable: modificable ?? this.modificable,
      manejaMm: manejaMm ?? this.manejaMm,
    );
  }

  @override
  List<Object?> get props => [
        idTanque,
        idCompania,
        idCentroVenta,
        idArticulo,
        idConsolaTanque,
        capacidad,
        alturaTanque,
        descripcion,
        porcentajeMinimoCombustible,
        alturaOffset,
        factorInicioDescargue,
        codigo,
        alturaAguaOffset,
        offsetInclinacion,
        estado,
        modificable,
        manejaMm,
      ];

  @override
  // TODO: implement id
  int get id => idTanque;

  @override
  // TODO: implement text
  String get text => descripcion;
}
