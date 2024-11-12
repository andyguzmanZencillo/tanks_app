import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/features/tanks/helpers/upsert_tanks_inherited.dart';

extension MapInheritedToEntity on UpsertTanksInherited {
  TanksEntity toTankEntity() {
    return TanksEntity(
      idTanque: 0,
      idCompania: 0,
      idCentroVenta: saleCenter.getValue().id,
      idArticulo: article.getValue().id,
      idConsolaTanque:
          console.getValue().id == 0 ? null : console.getValue().id,
      capacidad: capacidadField.getValue().toDoubleSafe(),
      alturaTanque: alturaTanqueField.getValue().toDoubleSafe(),
      descripcion: descripcionField.getValue(),
      porcentajeMinimoCombustible:
          porcentajeMinimoCombustibleField.getValue().toDoubleSafe(),
      alturaOffset: alturaOffsetField.getValue().toDoubleSafe(),
      factorInicioDescargue:
          factorInicioDescargueField.getValue().toDoubleSafe(),
      codigo: codigoField.getValue().toIntSafe(),
      alturaAguaOffset: alturaAguaOffsetField.getValue().toDoubleSafe(),
      offsetInclinacion: offsetInclinacionField.getValue().toDoubleSafe(),
      estado: false,
      modificable: false,
      manejaMm: false,
    );
  }

  TanksEntity toTankEntityUpdate(TanksEntity entity) {
    return entity.copyWith(
      idCentroVenta: saleCenter.getValue().id,
      idArticulo: article.getValue().id,
      idConsolaTanque: console.getValue().id,
      capacidad: capacidadField.getValue().toDoubleSafe(),
      alturaTanque: alturaTanqueField.getValue().toDoubleSafe(),
      descripcion: descripcionField.getValue(),
      porcentajeMinimoCombustible:
          porcentajeMinimoCombustibleField.getValue().toDoubleSafe(),
      alturaOffset: alturaOffsetField.getValue().toDoubleSafe(),
      factorInicioDescargue:
          factorInicioDescargueField.getValue().toDoubleSafe(),
      codigo: codigoField.getValue().toIntSafe(),
      alturaAguaOffset: alturaAguaOffsetField.getValue().toDoubleSafe(),
      offsetInclinacion: offsetInclinacionField.getValue().toDoubleSafe(),
    );
  }
}
