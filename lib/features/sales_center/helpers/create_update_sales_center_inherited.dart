import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';

class CreateUpdateSalesCenterInherited extends InheritedWidget {
  CreateUpdateSalesCenterInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;

  final saleCenter = ControllerFieldPro();
  final description = ControllerFieldPro();
  final email = ControllerFieldPro();

  final formKey = GlobalKey<FormState>();

  static CreateUpdateSalesCenterInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<CreateUpdateSalesCenterInherited>();
    assert(result != null, 'No  FormInherited found in context');
    return result!;
  }

  void setData(SalesCenterEntity salesCenterEntity) {
    saleCenter.setValue(salesCenterEntity.centroVenta);
    description.setValue(salesCenterEntity.descripcion);
    email.setValue(salesCenterEntity.correo);
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
