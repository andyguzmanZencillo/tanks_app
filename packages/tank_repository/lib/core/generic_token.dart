import 'dart:io';

import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/extension_result.dart';

Future<Result<T, Failure>> handleExceptionCompleteToken<T>(
  Future<T> Function() action, {
  bool retri = true,
}) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on NetworkRequestException {
    return const Result.err(NetworkRequestFailure());
  } on UnauthorizedAccessException {
    if (retri) {
      final user = await UserDatabase().getUser();
      final resultToken = await handleExceptionCompleteToken<String>(
        () async {
          final result = await TokenApi().getToken(
            idCompany: user.idZencilloCompany.toString(),
            user: user.login,
            password: user.password,
          );
          return result.token;
        },
        retri: false,
      );
      if (resultToken.isErr()) return resultToken.fail();

      return handleExceptionCompleteToken(action, retri: false);
    } else {
      return const Result.err(NetworkRequestFailure());
    }
  } on NoInternetConnectionException {
    return const Result.err(NoInternetConnectionFailure());
  } on SocketException {
    return const Result.err(
      NoInternetConnectionFailure('Error de conexión con el servidor'),
    );
  } on ServerResponseException {
    return const Result.err(ServerResponseFailure());
  } on InvalidDataException catch (e) {
    return Result.err(InvalidDataFailure(e.message));
  } on ConfigurationException catch (e) {
    return Result.err(ConfigurationFailure(e.message));
  } on DatabaseErrorException {
    return const Result.err(DatabaseErrorFailure());
  } on DataNotFoundException {
    return const Result.err(DataNotFoundFailure());
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

Future<Result<T, Failure>> handleException<T>(
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
