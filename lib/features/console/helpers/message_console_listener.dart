import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageConsoleListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(
      message: 'Cargando lista de consolas de tanque. Por favor, espere...',
    );
  }

  static DialogMessage get successGet {
    return const DialogMessage(
      message: 'Lista de consolas de tanque cargada exitosamente.',
      showSuccess: false,
    );
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(
      message: 'Registrando nueva consola de tanque. Por favor, espere...',
    );
  }

  static DialogMessage get successCreate {
    return const DialogMessage(
      message: 'Consola de tanque registrada con éxito.',
    );
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información de la consola de tanque...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(
      message: 'Consola de tanque actualizada con éxito.',
    );
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(message: 'Eliminando consola de tanque...');
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Consola de tanque eliminada con éxito.',
      pop: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message: 'Ha ocurrido un error. Por favor, inténtelo de nuevo.',
    );
  }
}
