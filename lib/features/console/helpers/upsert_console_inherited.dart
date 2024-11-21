import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';

class UpsertConsoleInherited extends InheritedWidget {
  UpsertConsoleInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final consoleProtocol = ControllerFieldDropdown<ConsoleProtocolEntity>();
  final consolaField = ControllerFieldPro();
  final descripcionField = ControllerFieldPro();
  final idConsolaTanqueProtocoloField = ControllerFieldPro();
  final tipoField = ControllerFieldDropdown<String>();
  final ipField = ControllerFieldPro();
  final socketField = ControllerFieldPro();
  final puertoSerialField = ControllerFieldPro();
  final contrasenaIpField = ControllerFieldPro();

  final formKey = GlobalKey<FormState>();

  static UpsertConsoleInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertConsoleInherited>();
    assert(result != null, 'No UpsertConsoleInherited found in context');
    return result!;
  }

  void setDate(ConsoleEntity consoleEntity) {
    consolaField.setValue(consoleEntity.consola);
    descripcionField.setValue(consoleEntity.descripcion);
    idConsolaTanqueProtocoloField
        .setValue(consoleEntity.idConsolaTanqueProtocolo.toString());
    tipoField.setValue(ValueExtend(text: consoleEntity.tipo));
    ipField.setValue(consoleEntity.ip ?? '');
    socketField.setValue(consoleEntity.socket);
    puertoSerialField.setValue(consoleEntity.puertoSerial ?? '');
    contrasenaIpField.setValue(consoleEntity.contrasenaIp);
  }

  void dispose() {
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
    consolaField.textEditingController.clear();
    descripcionField.textEditingController.clear();
    idConsolaTanqueProtocoloField.textEditingController.clear();

    ipField.textEditingController.clear();
    socketField.textEditingController.clear();
    puertoSerialField.textEditingController.clear();
    contrasenaIpField.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      consolaField.fieldKey,
      descripcionField.fieldKey,
      idConsolaTanqueProtocoloField.fieldKey,
      tipoField.fieldKey,
      ipField.fieldKey,
      socketField.fieldKey,
      puertoSerialField.fieldKey,
      contrasenaIpField.fieldKey,
      idConsolaTanqueProtocoloField.fieldKey,
      consoleProtocol.fieldKey,
    ]);
  }
}
