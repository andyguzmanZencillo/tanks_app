import 'package:tank_api/features/company/models/company_request.dart';

class MultiTableRequest extends RequestBase {
  MultiTableRequest({
    super.query = 'FNZSTanques_multi_table_crud',
  });
}

class GetCentroVentaArticuloConsolaRequest extends MultiTableRequest {
  GetCentroVentaArticuloConsolaRequest({
    required this.idCompania,
    required this.idUsuario,
    this.idUserTrace = 123,
    this.operation = 'S_CentroVentaArticuloConsola',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_compania': idCompania,
    });
  }
}
