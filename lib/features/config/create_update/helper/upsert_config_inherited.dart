import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertConfigInherited extends InheritedWidget {
  UpsertConfigInherited({
    required super.child,
    required this.typeOperation,
    this.configEntity = const ConfigEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {}
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final ConfigEntity configEntity;

  final formKey = GlobalKey<FormState>();

  static UpsertConfigInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertConfigInherited>();
    assert(result != null, 'No UpsertConsoleInherited found in context');
    return result!;
  }

  void dispose() {}

  ResultValidate valid() {
    return formKey.validateAndGetErrors([]);
  }
}
