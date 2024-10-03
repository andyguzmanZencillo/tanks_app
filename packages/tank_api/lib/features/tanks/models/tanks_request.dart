import 'package:tank_api/features/company/company.dart';

class TanksRequest extends RequestBase {
  TanksRequest({super.query = 'FNZSTanques_crud_tanques'});
}

class InsertTanksRequest extends TanksRequest {
  InsertTanksRequest({
    required this.idCompania,
    required this.idCentroVenta,
    required this.idArticulo,
    required this.idConsolaTanque,
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
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idCentroVenta;
  final int idArticulo;
  final int idConsolaTanque;
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

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_centro_venta': idCentroVenta,
      'id_articulo': idArticulo,
      'id_consola_tanque': idConsolaTanque,
      'capacidad': capacidad,
      'altura_tanque': alturaTanque,
      'descripcion': descripcion,
      'porcentaje_minimo_combustible': porcentajeMinimoCombustible,
      'altura_offset': alturaOffset,
      'factor_inicio_descargue': factorInicioDescargue,
      'codigo': codigo,
      'altura_agua_offset': alturaAguaOffset,
      'offset_inclinacion': offsetInclinacion,
      'estado': estado,
      'modificable': modificable,
      'maneja_mm': manejaMm,
    });
  }
}

class UpdateTanksRequest extends TanksRequest {
  UpdateTanksRequest({
    required this.idTank,
    required this.idCompania,
    required this.idCentroVenta,
    required this.idArticulo,
    required this.idConsolaTanque,
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
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idTank;
  final int idCentroVenta;
  final int idArticulo;
  final int idConsolaTanque;
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

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_tanque': idTank,
      'id_compania': idCompania,
      'id_centro_venta': idCentroVenta,
      'id_articulo': idArticulo,
      'id_consola_tanque': idConsolaTanque,
      'capacidad': capacidad,
      'altura_tanque': alturaTanque,
      'descripcion': descripcion,
      'porcentaje_minimo_combustible': porcentajeMinimoCombustible,
      'altura_offset': alturaOffset,
      'factor_inicio_descargue': factorInicioDescargue,
      'codigo': codigo,
      'altura_agua_offset': alturaAguaOffset,
      'offset_inclinacion': offsetInclinacion,
      'estado': estado,
      'modificable': modificable,
      'maneja_mm': manejaMm,
    });
  }
}

class GetTanksRequest extends TanksRequest {
  GetTanksRequest({
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
    });
  }
}

class DeleteTanksRequest extends TanksRequest {
  DeleteTanksRequest({
    required this.idTank,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idTank;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_tanque': idTank,
      'id_compania': idCompania,
    });
  }
}
