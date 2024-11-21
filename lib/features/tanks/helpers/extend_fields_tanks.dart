import 'package:flutter/services.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';

class ExtendFieldsTanks {
  static ExtendTextField get capacity => ExtendTextField(
        label: 'Capacidad',
        title: 'Capacidad',
        maxLength: 35,
        validators: [
          RequiredValid(
            error: 'Campo requerido',
          ),
        ],
        inputType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get alturaTanque => ExtendTextField(
        label: 'Altura tanque',
        title: 'Altura tanque',
        maxLength: 35,
        inputType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        validators: [
          RequiredValid(
            error: 'Campo requerido',
          ),
        ],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get descripcion => ExtendTextField(
        label: 'Descripción',
        title: 'Descripción',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          AlphanumericWithSpaceNoLeadingInputFormatter(),
        ],
      );
  static ExtendTextField get alturaOffset => ExtendTextField(
        label: 'Altura Offset',
        title: 'Altura Offset',
        maxLength: 35,
        inputType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get factorInicioDescargue => ExtendTextField(
        label: 'Fac inicio descargue',
        title: 'Fac inicio descargue',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get codigo => ExtendTextField(
        label: 'Codigo',
        title: 'Codigo',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      );
  static ExtendTextField get alturaAguaOffset => ExtendTextField(
        label: 'Altura agua offset',
        title: 'Altura agua offset',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get offsetInclinacion => ExtendTextField(
        label: 'Offset inclinación',
        title: 'Offset inclinación',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
  static ExtendTextField get porcentajeMinimoCombustible => ExtendTextField(
        label: '% Min. Combustible',
        title: '% Min. Combustible',
        maxLength: 35,
        validators: [RequiredValid(error: 'Campo requerido')],
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 3),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,3}'),
          ),
        ],
      );
}
