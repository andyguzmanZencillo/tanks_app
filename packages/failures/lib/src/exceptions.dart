/// Excepción lanzada cuando falla una solicitud de red
class NetworkRequestException implements Exception {}

/// Excepción lanzada cuando el servidor devuelve un error inesperado
class ServerResponseException implements Exception {}

/// Excepción lanzada cuando ocurre un error en la base de datos
class DatabaseErrorException implements Exception {}

/// Excepción lanzada cuando no se encuentran datos en la base de datos
class DataNotFoundException implements Exception {}

/// Excepción lanzada cuando se intenta acceder sin permisos válidos
class UnauthorizedAccessException implements Exception {}

/// Excepción lanzada cuando no hay conexión a Internet
class NoInternetConnectionException implements Exception {}

/// Excepción lanzada cuando los datos recibidos son nulos o inválidos
class InvalidDataException implements Exception {
  const InvalidDataException(this.message);
  final String message;
}

/// Excepción lanzada cuando la operación falla por una configuración incorrecta
class ConfigurationException implements Exception {
  const ConfigurationException(this.message);
  final String message;
}

/// Excepción lanzada cuando ocurre un error desconocido en la aplicación
class UnknownApplicationException implements Exception {
  const UnknownApplicationException([
    this.message = 'Error desconocido en la aplicación',
  ]);
  final String message;

  @override
  String toString() => 'UnknownApplicationException: $message';
}
