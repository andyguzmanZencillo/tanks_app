import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/binnacle/entity/binnacle_entity.dart';

extension MapperBinnacleResponseToEntity on BinnacleResponse {
  BinnacleEntity toEntity() {
    return BinnacleEntity(
      idBitacora: idBitacora,
      idCompania: idCompania,
      idTanque: idTanque,
      idCentroVenta: idCentroVenta,
      descripcion: descripcion,
      codigoTanque: codigoTanque,
      saldo: saldo,
      agua: agua,
      descargue: descargue,
      saldoAltura: saldoAltura,
      aguaAltura: aguaAltura,
      volumenReal: volumenReal,
      fechaLectura: fechaLectura,
      hora: hora,
    );
  }
}
