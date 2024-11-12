import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageTanksListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(
      message: 'Cargando lista de tanques. Por favor, espere...',
    );
  }

  static DialogMessage get successGet {
    return const DialogMessage(
      message: 'Lista de tanques cargada exitosamente.',
      showSuccess: false,
    );
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(
      message: 'Registrando nuevo tanque. Por favor, espere...',
    );
  }

  static DialogMessage get successCreate {
    return const DialogMessage(
      message: 'Tanque registrado con éxito.',
    );
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información del tanque...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(
      message: 'Tanque actualizado con éxito.',
    );
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(
      message: 'Eliminando tanque...',
    );
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Tanque eliminado con éxito.',
      pop: false,
    );
  }

  static DialogMessage get loadingPrepare {
    return const DialogMessage(
      message: 'Preparando información para crear un tanque...',
    );
  }

  static DialogMessage get successPrepare {
    return const DialogMessage(
      message: 'Información preparada exitosamente para crear un tanque.',
      showSuccess: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message:
          'Ha ocurrido un error al procesar el tanque. Por favor, inténtelo de nuevo.',
    );
  }
}
