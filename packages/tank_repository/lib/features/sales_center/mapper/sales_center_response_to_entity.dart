import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';

extension SalesCenterResponseToEntity on SalesCenterResponse {
  SalesCenterEntity toEntity() {
    return SalesCenterEntity(
      idCentroVenta: idCentroVenta,
      idCompania: idCompania,
      centroVenta: centroVenta,
      descripcion: descripcion,
      correo: correo,
    );
  }
}
