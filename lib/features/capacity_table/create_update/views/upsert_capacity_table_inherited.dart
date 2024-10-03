import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertCapacityTableInherited extends InheritedWidget {
  UpsertCapacityTableInherited({
    required super.child,
    required this.typeOperation,
    this.tanksEntity = const CapacityTableEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      alturaTanqueField.setValue(tanksEntity.alturaTanque.toString());
      volumen.setValue(tanksEntity.volumen.toString());
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final CapacityTableEntity tanksEntity;

  final ControllerField alturaTanqueField = ControllerField();
  final ControllerField volumen = ControllerField();

  final ControllerFieldDropdown<ValueExtend> tanque = ControllerFieldDropdown();

  final formKey = GlobalKey<FormState>();

  static UpsertCapacityTableInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<UpsertCapacityTableInherited>();
    assert(result != null, 'No UpsertCapacityTableInherited found in context');
    return result!;
  }

  void dispose() {
    alturaTanqueField.dispose();
    volumen.dispose();
  }

  void clear() {
    alturaTanqueField.textEditingController.clear();
    volumen.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      alturaTanqueField.fieldKey,
      volumen.fieldKey,
      tanque.fieldKey,
    ]);
  }
}
