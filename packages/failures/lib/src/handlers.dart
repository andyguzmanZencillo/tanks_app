import 'dart:io';

import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';

Future<Result<T, Failure>> handleExceptions<T>(
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

Future<Result<T, Failure>> handleExceptionsLocal<T>(
  Future<T> Function() action,
) async {
  try {
    final result = await action();
    return Result.ok(result);
  } on DatabaseException {
    return Result.err(DatabaseFailure());
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
      ResultFailure(e.toString()),
    );
  } catch (e) {
    if (e is TypeError) {
      return Result.err(ResultFailure(e.toString()));
    } else {
      return Result.err(ResultFailure(e.toString()));
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
    return Result.err(ResultFailure(e.message));
  } on InvalidResolutionException {
    return Result.err(InvalidResolutionFailure());
  } on NoResolutionException catch (e) {
    return Result.err(NoResolutionFailure(e.message));
  } on DatabaseException {
    return Result.err(DatabaseFailure());
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
