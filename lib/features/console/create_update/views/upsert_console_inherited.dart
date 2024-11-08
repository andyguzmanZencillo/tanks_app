import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';

class UpsertConsoleInherited extends InheritedWidget {
  UpsertConsoleInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;

  final consolaField = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
  );
  final descripcionField = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
  );
  final idConsolaTanqueProtocoloField = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );
  final tipoField = ControllerFieldDropdown<String>();
  final ipField = ControllerField(
      /*validators: [
      RequiredValid(error: 'Campo requerido'),
      IPValid(error: 'Formato IP invalido'),
    ],*/
      );
  final socketField = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );
  final puertoSerialField = ControllerField(
      /*validators: [
      RequiredValid(error: 'Campo requerido'),
    ],*/
      );
  final contrasenaIpField = ControllerField(
    validators: [
      RequiredValid(error: 'Campo requerido'),
    ],
  );

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
    ]);
  }
}
