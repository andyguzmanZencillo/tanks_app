import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';

class ExtendFieldsSaleCenter {
  static ExtendTextField get saleCenter => ExtendTextField(
        label: 'Centro de venta',
        title: 'Centro de venta',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo centro de venta requerido',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );
  static ExtendTextField get description => ExtendTextField(
        label: 'Descripción',
        title: 'Descripción',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo descripción requerido',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );
  static ExtendTextField get email => ExtendTextField(
        label: 'Correo electronico',
        title: 'Correo electronico',
        inputType: TextInputType.emailAddress,
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo correo electronico requerido',
          ),
          EmailValid(error: 'Formato de correo invalido'),
        ],
        inputFormatters: [RemoveSpacesFormatter()],
      );
}
