import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertTanksInherited extends InheritedWidget {
  UpsertTanksInherited({
    required super.child,
    required this.typeOperation,
    this.tanksEntity = const TanksEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      capacidadField.setValue(tanksEntity.capacidad.toString());
      alturaTanqueField.setValue(tanksEntity.alturaTanque.toString());
      descripcionField.setValue(tanksEntity.descripcion);
      porcentajeMinimoCombustibleField
          .setValue(tanksEntity.porcentajeMinimoCombustible.toString());
      alturaOffsetField.setValue(tanksEntity.alturaOffset.toString());
      factorInicioDescargueField
          .setValue(tanksEntity.factorInicioDescargue.toString());
      codigoField.setValue(tanksEntity.codigo.toString());
      alturaAguaOffsetField.setValue(tanksEntity.alturaAguaOffset.toString());
      offsetInclinacionField.setValue(tanksEntity.offsetInclinacion.toString());
      estadoField.setValue(tanksEntity.estado.toString());
      modificableField.setValue(tanksEntity.modificable.toString());
      manejaMmField.setValue(tanksEntity.manejaMm.toString());
    }
    /*.setValue(
      const SalesCenterEntity.empty().copyWith(centroVenta: 'asdasd'),
    );*/
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final TanksEntity tanksEntity;

  // Campos relacionados con TanksEntity
  final ControllerField capacidadField = ControllerField();
  final ControllerField alturaTanqueField = ControllerField();
  final ControllerField descripcionField = ControllerField();
  final ControllerField porcentajeMinimoCombustibleField = ControllerField();
  final ControllerField alturaOffsetField = ControllerField();
  final ControllerField factorInicioDescargueField = ControllerField();
  final ControllerField codigoField = ControllerField();
  final ControllerField alturaAguaOffsetField = ControllerField();
  final ControllerField offsetInclinacionField = ControllerField();
  final ControllerField estadoField = ControllerField();
  final ControllerField modificableField = ControllerField();
  final ControllerField manejaMmField = ControllerField();

  final ControllerFieldDropdown<ValueExtend> saleCenter =
      ControllerFieldDropdown();
  final ControllerFieldDropdown<ValueExtend> console =
      ControllerFieldDropdown();
  final ControllerFieldDropdown<ValueExtend> article =
      ControllerFieldDropdown();

  final formKey = GlobalKey<FormState>();

  static UpsertTanksInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertTanksInherited>();
    assert(result != null, 'No UpsertTanksInherited found in context');
    return result!;
  }

  void dispose() {
    capacidadField.dispose();
    alturaTanqueField.dispose();
    descripcionField.dispose();
    porcentajeMinimoCombustibleField.dispose();
    alturaOffsetField.dispose();
    factorInicioDescargueField.dispose();
    codigoField.dispose();
    alturaAguaOffsetField.dispose();
    offsetInclinacionField.dispose();
    estadoField.dispose();
    modificableField.dispose();
    manejaMmField.dispose();
    saleCenter.dispose();
    console.dispose();
    article.dispose();
  }

  void clear() {
    capacidadField.textEditingController.clear();
    alturaTanqueField.textEditingController.clear();
    descripcionField.textEditingController.clear();
    porcentajeMinimoCombustibleField.textEditingController.clear();
    alturaOffsetField.textEditingController.clear();
    factorInicioDescargueField.textEditingController.clear();
    codigoField.textEditingController.clear();
    alturaAguaOffsetField.textEditingController.clear();
    offsetInclinacionField.textEditingController.clear();
    estadoField.textEditingController.clear();
    modificableField.textEditingController.clear();
    manejaMmField.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      capacidadField.fieldKey,
      alturaTanqueField.fieldKey,
      descripcionField.fieldKey,
      porcentajeMinimoCombustibleField.fieldKey,
      alturaOffsetField.fieldKey,
      factorInicioDescargueField.fieldKey,
      codigoField.fieldKey,
      alturaAguaOffsetField.fieldKey,
      offsetInclinacionField.fieldKey,
      estadoField.fieldKey,
      modificableField.fieldKey,
      manejaMmField.fieldKey,
      saleCenter.fieldKey,
      console.fieldKey,
      article.fieldKey,
    ]);
  }
}
