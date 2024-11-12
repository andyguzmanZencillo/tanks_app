import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageConsoleProtocolListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(
      message:
          'Cargando lista de protocolos de consola de tanque. Por favor, espere...',
    );
  }

  static DialogMessage get successGet {
    return const DialogMessage(
      message: 'Lista de protocolos de consola de tanque cargada exitosamente.',
      showSuccess: false,
    );
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(
      message:
          'Registrando nuevo protocolo de consola de tanque. Por favor, espere...',
    );
  }

  static DialogMessage get successCreate {
    return const DialogMessage(
      message: 'Protocolo de consola de tanque registrado con éxito.',
    );
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información del protocolo de consola de tanque...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(
      message: 'Protocolo de consola de tanque actualizado con éxito.',
    );
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(
        message: 'Eliminando protocolo de consola de tanque...');
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Protocolo de consola de tanque eliminado con éxito.',
      pop: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message:
          'Ha ocurrido un error al procesar el protocolo de consola de tanque. Por favor, inténtelo de nuevo.',
    );
  }
}
