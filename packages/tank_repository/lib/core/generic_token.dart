import 'dart:io';

import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/core/extension_result.dart';

Future<Result<T, Failure>> handleExceptionToken<T>(
  Future<T> Function() action, {
  bool retri = true,
}) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on RequestException {
    return Result.err(RequestFailure());
  } on UnauthorizedException {
    if (retri) {
      final resultToken = await handleExceptionToken<String>(
        () async {
          final result = await TokenApi().getToken(
            idCompany: '900176',
            user: 'usuario_prueba',
            password: 'contrasena_prueba',
          );
          return result;
        },
        retri: false,
      );
      if (resultToken.isErr()) return resultToken.fail();

      return handleExceptionToken(action, retri: false);
    } else {
      return Result.err(RequestFailure());
    }
  } on NoInternetException {
    return Result.err(NoInternetFailure());
  } on SocketException {
    return Result.err(SocketFailure());
  } on ResultException catch (e) {
    return Result.err(ResultFailure(e.message));
  } on InvalidResolutionException {
    return Result.err(InvalidResolutionFailure());
  } on NoResolutionException catch (e) {
    return Result.err(NoResolutionFailure(e.message));
  } on Exception catch (e) {
    return Result.err(ResultFailure(e.toString()));
  } catch (e) {
    if (e is TypeError) {
      return Result.err(ResultFailure(e.toString()));
    } else {
      return Result.err(ResultFailure(e.toString()));
    }
  }
}
