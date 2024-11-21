import 'package:flutter/material.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';

class UpsertTanksInherited extends InheritedWidget {
  UpsertTanksInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;

  final saleCenter = ControllerFieldDropdown<SalesCenterEntity>();
  final article = ControllerFieldDropdown<ArticleEntity>();
  final console = ControllerFieldDropdown<ConsoleEntity>();

  final capacidadField = ControllerFieldPro();
  final alturaTanqueField = ControllerFieldPro();

  final descripcionField = ControllerFieldPro();

  final alturaOffsetField = ControllerFieldPro();
  final factorInicioDescargueField = ControllerFieldPro();

  final codigoField = ControllerFieldPro();
  final alturaAguaOffsetField = ControllerFieldPro();

  final offsetInclinacionField = ControllerFieldPro();
  final porcentajeMinimoCombustibleField = ControllerFieldPro();

  final formKey = GlobalKey<FormState>();

  static UpsertTanksInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertTanksInherited>();
    assert(result != null, 'No UpsertTanksInherited found in context');
    return result!;
  }

  void setData(TanksEntity tanksEntity) {
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
      saleCenter.fieldKey,
      console.fieldKey,
      article.fieldKey,
    ]);
  }
}
