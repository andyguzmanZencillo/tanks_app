import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_date.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_inherited.dart';

extension MapperControllerToEntity on UpsertTankVariationInherited {
  TankVariationEntity toTankVariationEntity(
    int idTanque,
    DateTime dateRegister,
  ) {
    final variacion =
        compra.getValue().toDoubleSafe() - descargue.getValue().toDoubleSafe();
    return TankVariationEntity(
      idVariacion: 0,
      idCompania: 0,
      idTanque: idTanque,
      fechaZ: dateRegister.singleDate(),
      saldoInicial: saldoInicial.getValue().toDoubleSafe(),
      comprasFacturas: compra.getValue().toDoubleSafe(),
      descargue: descargue.getValue().toDoubleSafe(),
      inventarioFinalFisico: saldoFinal.getValue().toDoubleSafe(),
      variacionEnTransito: variacion,
      aguaInicial: aguaInicial.getValue().toDoubleSafe(),
      aguaFinal: aguaFinal.getValue().toDoubleSafe(),
      saldoFinal: saldoFinal.getValue().toDoubleSafe(),
    );
  }
}
