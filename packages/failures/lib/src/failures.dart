abstract class Failure {
  const Failure(this.message);
  final String message;
}

/// Representa un fallo en la solicitud de red
class NetworkRequestFailure extends Failure {
  const NetworkRequestFailure([super.message = 'Error en la solicitud de red']);
}

/// Representa un fallo en la respuesta del servidor
class ServerResponseFailure extends Failure {
  const ServerResponseFailure([
    super.message = 'Error inesperado en la respuesta del servidor',
  ]);
}

/// Representa un fallo en la base de datos
class DatabaseErrorFailure extends Failure {
  const DatabaseErrorFailure([
    super.message = 'Error al acceder a la base de datos',
  ]);
}

/// Representa la ausencia de datos en la base de datos
class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure([super.message = 'Datos no encontrados']);
}

/// Representa un fallo por falta de permisos
class UnauthorizedAccessFailure extends Failure {
  const UnauthorizedAccessFailure([super.message = 'Acceso no autorizado']);
}

/// Representa la falta de conexión a Internet
class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure([
    super.message = 'No hay conexión a Internet',
  ]);
}

/// Representa datos inválidos o nulos
class InvalidDataFailure extends Failure {
  const InvalidDataFailure([super.message = 'Datos inválidos o nulos']);
}

/// Representa una falla de configuración
class ConfigurationFailure extends Failure {
  const ConfigurationFailure([super.message = 'Error de configuración']);
}

/// Representa un fallo desconocido en la aplicación
class UnknownApplicationFailure extends Failure {
  const UnknownApplicationFailure([
    super.message = 'Error desconocido en la aplicación',
  ]);
}
