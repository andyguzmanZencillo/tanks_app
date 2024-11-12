/*import 'dart:io';

import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';

Future<Result<T, Failure>> handleExceptions<T>(
  Future<T> Function() action,
) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on NetworkRequestException {
    return const Result.err(NetworkRequestFailure());
  } on NoInternetConnectionException {
    return const Result.err(NoInternetConnectionFailure());
  } on SocketException {
    return const Result.err(
      NoInternetConnectionFailure('Error de conexión con el servidor'),
    );
  } on ServerResponseException {
    return const Result.err(ServerResponseFailure());
  } on DataNotFoundException {
    return const Result.err(DataNotFoundFailure());
  } on UnauthorizedAccessException {
    return const Result.err(UnauthorizedAccessFailure());
  } on InvalidDataException catch (e) {
    return Result.err(InvalidDataFailure(e.message));
  } on ConfigurationException catch (e) {
    return Result.err(ConfigurationFailure(e.message));
  } on UnknownApplicationException catch (e) {
    return Result.err(UnknownApplicationFailure(e.message));
  } on Exception catch (e) {
    return Result.err(UnknownApplicationFailure(e.toString()));
  } catch (e) {
    if (e is TypeError) {
      return Result.err(UnknownApplicationFailure(e.toString()));
    } else {
      return Result.err(UnknownApplicationFailure(e.toString()));
    }
  }
}

Future<Result<T, Failure>> handleExceptionsLocal<T>(
  Future<T> Function() action,
) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on DatabaseErrorException {
    return const Result.err(DatabaseErrorFailure());
  } on DataNotFoundException {
    return const Result.err(DataNotFoundFailure());
  } on InvalidDataException catch (e) {
    return Result.err(InvalidDataFailure(e.message));
  } on Exception catch (e) {
    return Result.err(UnknownApplicationFailure(e.toString()));
  } catch (e) {
    if (e is TypeError) {
      return Result.err(UnknownApplicationFailure(e.toString()));
    } else {
      return Result.err(UnknownApplicationFailure(e.toString()));
    }
  }
}*/

/*
Future<Result<T, Failure>> handleDeviceExceptions<T>(
  Future<T> Function() action,
) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on SocketException {
    return Result.err(SocketFailure());
  } on Exception catch (e) {
    return Result.err(
      InvalidDataFailure(e.toString()),
    );
  } catch (e) {
    if (e is TypeError) {
      return Result.err(InvalidDataFailure(e.toString()));
    } else {
      return Result.err(InvalidDataFailure(e.toString()));
    }
  }
}

Future<Result<T, Failure>> handleExceptionsComplete<T>(
  Future<T> Function() action,
) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on RequestException {
    return Result.err(RequestFailure());
  } on NoInternetException {
    return Result.err(NoInternetFailure());
  } on SocketException {
    return Result.err(SocketFailure());
  } on ResultException catch (e) {
    return Result.err(InvalidDataFailure(e.message));
  } on InvalidResolutionException {
    return Result.err(InvalidResolutionFailure());
  } on NoResolutionException catch (e) {
    return Result.err(NoResolutionFailure(e.message));
  } on DatabaseException {
    return Result.err(DatabaseFailure());
  } on Exception catch (e) {
    return Result.err(InvalidDataFailure(e.toString()));
  } catch (e) {
    if (e is TypeError) {
      return Result.err(InvalidDataFailure(e.toString()));
    } else {
      return Result.err(InvalidDataFailure(e.toString()));
    }
  }
}
*/