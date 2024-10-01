import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class CreateUpdateSalesCenterInherited extends InheritedWidget {
  CreateUpdateSalesCenterInherited({
    required super.child,
    required this.typeOperation,
    this.salesCenterEntity = const SalesCenterEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      saleCenter.setValue(salesCenterEntity.centroVenta);
      description.setValue(salesCenterEntity.descripcion);
      email.setValue(salesCenterEntity.correo);
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final SalesCenterEntity salesCenterEntity;

  final saleCenter = ControllerField();
  final description = ControllerField();
  final email = ControllerField();

  final formKey = GlobalKey<FormState>();

  static CreateUpdateSalesCenterInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<CreateUpdateSalesCenterInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  void dispose() {
    saleCenter.dispose();
    description.dispose();
    email.dispose();
  }

  void clear() {
    description.textEditingController.clear();
    saleCenter.textEditingController.clear();
    email.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      saleCenter.fieldKey,
      description.fieldKey,
      email.fieldKey,
    ]);
  }
}
