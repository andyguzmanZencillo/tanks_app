import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageCapacityTableListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(
      message: 'Cargando lista de tablas de aforo. Por favor, espere...',
    );
  }

  static DialogMessage get successGet {
    return const DialogMessage(
      message: 'Lista de tablas de aforo cargada exitosamente.',
      showSuccess: false,
    );
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(
      message: 'Registrando nueva tabla de aforo. Por favor, espere...',
    );
  }

  static DialogMessage get successCreate {
    return const DialogMessage(
      message: 'Tabla de aforo registrada con éxito.',
    );
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información de la tabla de aforo...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(
      message: 'Tabla de aforo actualizada con éxito.',
    );
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(
      message: 'Eliminando tabla de aforo...',
    );
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Tabla de aforo eliminada con éxito.',
      pop: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message:
          'Ha ocurrido un error al procesar la tabla de aforo. Por favor, inténtelo de nuevo.',
    );
  }
}
