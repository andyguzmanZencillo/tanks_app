import 'package:tanks_app/core/helpers/dialog_info.dart';

class MessageSalesCenterListener {
  static DialogMessage get loadingGet {
    return const DialogMessage(
      message: 'Cargando la lista de centros de venta. Por favor, espere...',
    );
  }

  static DialogMessage get successGet {
    return const DialogMessage(
      message: 'Lista de centros de venta cargada exitosamente.',
      showSuccess: false,
    );
  }

  static DialogMessage get loadingCreate {
    return const DialogMessage(
      message: 'Guardando el nuevo centro de venta. Por favor, espere...',
    );
  }

  static DialogMessage get successCreate {
    return const DialogMessage(
      message: 'Centro de venta registrado con éxito.',
    );
  }

  static DialogMessage get loadingUpdate {
    return const DialogMessage(
      message: 'Actualizando información del centro de venta...',
    );
  }

  static DialogMessage get successUpdate {
    return const DialogMessage(
      message: 'Centro de venta actualizado con éxito.',
    );
  }

  static DialogMessage get loadingDelete {
    return const DialogMessage(message: 'Eliminando el centro de venta...');
  }

  static DialogMessage get successDelete {
    return const DialogMessage(
      message: 'Centro de venta eliminado con éxito.',
      pop: false,
    );
  }

  static DialogMessage get error {
    return const DialogMessage(
      message: 'Ha ocurrido un error. Por favor, inténtelo de nuevo.',
    );
  }
}
