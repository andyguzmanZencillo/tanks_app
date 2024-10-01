import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertConsoleInherited extends InheritedWidget {
  UpsertConsoleInherited({
    required super.child,
    required this.typeOperation,
    this.consoleEntity = const ConsoleEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      idConsolaField.setValue(consoleEntity.idConsola.toString());
      idCompaniaField.setValue(consoleEntity.idCompania.toString());
      consolaField.setValue(consoleEntity.consola);
      descripcionField.setValue(consoleEntity.descripcion);
      idConsolaTanqueProtocoloField
          .setValue(consoleEntity.idConsolaTanqueProtocolo.toString());
      tipoField.setValue(consoleEntity.tipo);
      ipField.setValue(consoleEntity.ip);
      socketField.setValue(consoleEntity.socket);
      puertoSerialField.setValue(consoleEntity.puertoSerial);
      contrasenaIpField.setValue(consoleEntity.contrasenaIp);
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final ConsoleEntity consoleEntity;

  final ControllerField idConsolaField = ControllerField();
  final ControllerField idCompaniaField = ControllerField();
  final ControllerField consolaField = ControllerField();
  final ControllerField descripcionField = ControllerField();
  final ControllerField idConsolaTanqueProtocoloField = ControllerField();
  final ControllerField tipoField = ControllerField();
  final ControllerField ipField = ControllerField();
  final ControllerField socketField = ControllerField();
  final ControllerField puertoSerialField = ControllerField();
  final ControllerField contrasenaIpField = ControllerField();

  final formKey = GlobalKey<FormState>();

  static UpsertConsoleInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertConsoleInherited>();
    assert(result != null, 'No UpsertConsoleInherited found in context');
    return result!;
  }

  void dispose() {
    idConsolaField.dispose();
    idCompaniaField.dispose();
    consolaField.dispose();
    descripcionField.dispose();
    idConsolaTanqueProtocoloField.dispose();
    tipoField.dispose();
    ipField.dispose();
    socketField.dispose();
    puertoSerialField.dispose();
    contrasenaIpField.dispose();
  }

  void clear() {
    idConsolaField.textEditingController.clear();
    idCompaniaField.textEditingController.clear();
    consolaField.textEditingController.clear();
    descripcionField.textEditingController.clear();
    idConsolaTanqueProtocoloField.textEditingController.clear();
    tipoField.textEditingController.clear();
    ipField.textEditingController.clear();
    socketField.textEditingController.clear();
    puertoSerialField.textEditingController.clear();
    contrasenaIpField.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      idConsolaField.fieldKey,
      idCompaniaField.fieldKey,
      consolaField.fieldKey,
      descripcionField.fieldKey,
      idConsolaTanqueProtocoloField.fieldKey,
      tipoField.fieldKey,
      ipField.fieldKey,
      socketField.fieldKey,
      puertoSerialField.fieldKey,
      contrasenaIpField.fieldKey,
    ]);
  }
}
