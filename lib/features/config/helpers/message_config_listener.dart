import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageConfigListener {
  static const loading = DialogMessage(
    message: 'Cargando configuración...',
  );
  static const successLoad = DialogMessage(
    message: 'Configuración cargada con éxito.',
    showSuccess: false,
  );
  static const loadingCreate =
      DialogMessage(message: 'Creando configuración...');
  static const successCreate =
      DialogMessage(message: 'Configuración creada con éxito.');
  static const loadingUpdate =
      DialogMessage(message: 'Actualizando configuración...');
  static const successUpdate =
      DialogMessage(message: 'Configuración actualizada con éxito.');
  static const error =
      DialogMessage(message: 'Ha ocurrido un error. Inténtelo de nuevo.');
}
