import 'package:equatable/equatable.dart';

class TankVariationEntity extends Equatable {
  const TankVariationEntity({
    required this.idVariacion,
    required this.idCompania,
    required this.idTanque,
    required this.fechaZ,
    required this.saldoInicial,
    required this.comprasFacturas,
    required this.descargue,
    required this.variacionEnTransito,
    required this.aguaInicial,
    required this.aguaFinal,
    required this.saldoFinal,
    this.variacionTotalPorcentaje = '',
    this.variacionOperacionalPorcentaje = '',
    this.variacionOperacional = 0,
    this.inventarioFinalCalculado = 0,
    this.inventarioFinalFisico = 0,
    this.calibracion = 0,
    this.venta = 0,
    this.variacionTotal = 0,
    this.variacionTransitoPorcentaje = '',
  });

  const TankVariationEntity.empty()
      : idVariacion = 0,
        idCompania = 0,
        idTanque = 0,
        fechaZ = '',
        saldoInicial = 0.0,
        comprasFacturas = 0.0,
        descargue = 0.0,
        venta = 0.0,
        calibracion = 0.0,
        inventarioFinalCalculado = 0.0,
        inventarioFinalFisico = 0.0,
        variacionEnTransito = 0.0,
        variacionTransitoPorcentaje = '0%',
        variacionOperacional = 0.0,
        variacionOperacionalPorcentaje = '0%',
        variacionTotal = 0.0,
        variacionTotalPorcentaje = '0%',
        aguaInicial = 0.0,
        aguaFinal = 0.0,
        saldoFinal = 0.0;

  final int idVariacion;
  final int idCompania;
  final int idTanque;
  final String fechaZ;
  final double saldoInicial;
  final double comprasFacturas;
  final double descargue;
  final double venta;
  final double calibracion;
  final double inventarioFinalCalculado;
  final double inventarioFinalFisico;
  final double variacionEnTransito;
  final String variacionTransitoPorcentaje;
  final double variacionOperacional;
  final String variacionOperacionalPorcentaje;
  final double variacionTotal;
  final String variacionTotalPorcentaje;
  final double aguaInicial;
  final double aguaFinal;
  final double saldoFinal;

  // Método `copyWith`
  TankVariationEntity copyWith({
    int? idVariacion,
    int? idCompania,
    int? idTanque,
    String? fechaZ,
    double? saldoInicial,
    double? comprasFacturas,
    double? descargue,
    double? venta,
    double? calibracion,
    double? inventarioFinalCalculado,
    double? inventarioFinalFisico,
    double? variacionEnTransito,
    String? variacionTransitoPorcentaje,
    double? variacionOperacional,
    String? variacionOperacionalPorcentaje,
    double? variacionTotal,
    String? variacionTotalPorcentaje,
    double? aguaInicial,
    double? aguaFinal,
    double? saldoFinal,
  }) {
    return TankVariationEntity(
      idVariacion: idVariacion ?? this.idVariacion,
      idCompania: idCompania ?? this.idCompania,
      idTanque: idTanque ?? this.idTanque,
      fechaZ: fechaZ ?? this.fechaZ,
      saldoInicial: saldoInicial ?? this.saldoInicial,
      comprasFacturas: comprasFacturas ?? this.comprasFacturas,
      descargue: descargue ?? this.descargue,
      venta: venta ?? this.venta,
      calibracion: calibracion ?? this.calibracion,
      inventarioFinalCalculado:
          inventarioFinalCalculado ?? this.inventarioFinalCalculado,
      inventarioFinalFisico:
          inventarioFinalFisico ?? this.inventarioFinalFisico,
      variacionEnTransito: variacionEnTransito ?? this.variacionEnTransito,
      variacionTransitoPorcentaje:
          variacionTransitoPorcentaje ?? this.variacionTransitoPorcentaje,
      variacionOperacional: variacionOperacional ?? this.variacionOperacional,
      variacionOperacionalPorcentaje:
          variacionOperacionalPorcentaje ?? this.variacionOperacionalPorcentaje,
      variacionTotal: variacionTotal ?? this.variacionTotal,
      variacionTotalPorcentaje:
          variacionTotalPorcentaje ?? this.variacionTotalPorcentaje,
      aguaInicial: aguaInicial ?? this.aguaInicial,
      aguaFinal: aguaFinal ?? this.aguaFinal,
      saldoFinal: saldoFinal ?? this.saldoFinal,
    );
  }

  // Método `toJson`
  Map<String, dynamic> toJson() {
    return {
      'id_variacion': idVariacion,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'fecha_z': fechaZ,
      'saldo_inicial': saldoInicial,
      'compras_facturas': comprasFacturas,
      'descargue': descargue,
      'venta': venta,
      'calibracion': calibracion,
      'inventario_final_calculado': inventarioFinalCalculado,
      'inventario_final_fisico': inventarioFinalFisico,
      'variacion_en_transito': variacionEnTransito,
      'variacion_transito_porcentaje': variacionTransitoPorcentaje,
      'variacion_operacional': variacionOperacional,
      'variacion_operacional_porcentaje': variacionOperacionalPorcentaje,
      'variacion_total': variacionTotal,
      'variacion_total_porcentaje': variacionTotalPorcentaje,
      'agua_inicial': aguaInicial,
      'agua_final': aguaFinal,
      'saldo_final': saldoFinal,
    };
  }

  @override
  List<Object?> get props => [
        idVariacion,
        idCompania,
        idTanque,
        fechaZ,
        saldoInicial,
        comprasFacturas,
        descargue,
        venta,
        calibracion,
        inventarioFinalCalculado,
        inventarioFinalFisico,
        variacionEnTransito,
        variacionTransitoPorcentaje,
        variacionOperacional,
        variacionOperacionalPorcentaje,
        variacionTotal,
        variacionTotalPorcentaje,
        aguaInicial,
        aguaFinal,
        saldoFinal,
      ];
}
