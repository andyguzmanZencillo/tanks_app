import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageArticleListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(message: 'Cargando lista de artículos...');
  }

  static DialogMessage get successGet {
    return const DialogMessage(message: '', showSuccess: false);
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(message: 'Registrando nuevo artículo...');
  }

  static DialogMessage get successCreate {
    return const DialogMessage(message: 'Artículo registrado con éxito.');
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información del artículo...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(message: 'Artículo actualizado con éxito.');
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(message: 'Eliminando artículo...');
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Artículo eliminado con éxito.',
      pop: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message: 'Ha ocurrido un error. Por favor, inténtelo de nuevo.',
    );
  }
}
