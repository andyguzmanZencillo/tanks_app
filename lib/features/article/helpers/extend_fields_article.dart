import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';

class ExtendFieldsArticle {
  static ExtendTextField get nameArticle => ExtendTextField(
        label: 'Nombre Artículo',
        title: 'Nombre Artículo',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo nombre artículo requerido',
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
            error: 'Campo descripción requerida',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );
  static ExtendTextField get codeArticle => ExtendTextField(
        label: 'Codigo Artículo',
        title: 'Codigo Artículo',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo descripción requerida',
          ),
        ],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
          NoSpaceFormatter(),
        ],
      );
  static ExtendTextField get color => ExtendTextField(
        label: 'Color',
        title: 'Color',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo color requerido',
          ),
        ],
      );
  static ExtendTextField get price => ExtendTextField(
        label: 'Precio',
        title: 'Precio',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo precio requerido',
          ),
        ],
        inputFormatters: [
          //FilteringTextInputFormatter.digitsOnly,
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
          FilteringTextInputFormatter.deny(
            RegExp(r'\s'),
          ),
          NoOnlyZeroInputFormatter(),
        ],
      );
}
