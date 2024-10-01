import 'package:tank_api/features/company/company.dart';

class SalesCenterRequest extends RequestBase {
  SalesCenterRequest({super.query = 'FNZSTanques_crud_centro_venta'});
}

class InsertSalesCenterRequest extends SalesCenterRequest {
  InsertSalesCenterRequest({
    required this.idCompania,
    required this.salesCenter,
    required this.description,
    required this.email,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final String salesCenter;
  final String description;
  final String email;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'centro_venta': salesCenter,
      'descripcion': description,
      'correo': email,
    });
  }
}

class UpdateSalesCenterRequest extends SalesCenterRequest {
  UpdateSalesCenterRequest({
    required this.idSaleCenter,
    required this.idCompania,
    required this.salesCenter,
    required this.description,
    required this.email,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idSaleCenter;
  final String salesCenter;
  final String description;
  final String email;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_centro_venta': idSaleCenter,
      'centro_venta': salesCenter,
      'descripcion': description,
      'correo': email,
    });
  }
}

class GetSalesCenterRequest extends SalesCenterRequest {
  GetSalesCenterRequest({
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

class DeleteSalesCenterRequest extends SalesCenterRequest {
  DeleteSalesCenterRequest({
    required this.idSalesCenter,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idSalesCenter;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_centro_venta': idSalesCenter,
      'id_compania': idCompania,
    });
  }
}
