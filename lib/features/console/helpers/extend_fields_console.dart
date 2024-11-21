import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';

class ExtendFieldsConsole {
  static ExtendTextField get console => ExtendTextField(
        label: 'Nombre Consola',
        title: 'Nombre Consola',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo nombre consola requerido',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );

  static ExtendTextField get description => ExtendTextField(
        label: 'Descripción de la Consola',
        title: 'Descripción de la Consola',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo descripción de la consola requerido',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );

  static ExtendTextField get ip => ExtendTextField(
        label: 'IP de la Consola',
        title: 'IP de la Consola',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo IP de la consola requerido',
          ),
        ],
        inputFormatters: [
          IpAddressInputFormatter(),
        ],
      );

  static ExtendTextField get socket => ExtendTextField(
        label: 'Puerto de la Consola',
        title: 'Puerto de la Consola',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo puerto de la consola requerido',
          ),
        ],
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  static ExtendTextField get portSerial => ExtendTextField(
        label: 'Número de Serie',
        title: 'Número de Serie',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo número de serie requerido',
          ),
        ],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      );

  static ExtendTextField get passwordIp => ExtendTextField(
        label: 'Contraseña de la Consola',
        title: 'Contraseña de la Consola',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo contraseña de la consola requerido',
          ),
        ],
        inputFormatters: [
          NoSpaceFormatter(),
        ],
      );
}
