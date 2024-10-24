import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:failures/failures.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/user_device/map/user_alert_response_to_entity.dart';
import 'package:tank_repository/features/user_device/map/user_device_response_to_entity.dart';
import 'package:tank_repository/features/user_device/map/user_notification_response_to_entity.dart';
import 'package:tank_repository/features/user_device/user_device.dart';

class UserDeviceRepository {
  UserDeviceRepository({
    UserDeviceApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? UserDeviceApi();

  final UserDeviceApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<UserDeviceEntity>, Failure>> getUserDevice() {
    return handleExceptionCompleteToken<List<UserDeviceEntity>>(() async {
      final user = await _userDatabase.getUser();
      final dispositivo = await getDeviceModel();
      final request = GetUserDeviceRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        dispositivo: dispositivo,
      );
      final response = await _api.getUserDevice(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<UserAlertEntity>, Failure>> getUserAlert() {
    return handleExceptionCompleteToken<List<UserAlertEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetUserAlertRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
      );
      final response = await _api.getUserAlert(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<UserNotificationEntity>, Failure>> getUserNotification() {
    return handleExceptionCompleteToken<List<UserNotificationEntity>>(() async {
      final user = await _userDatabase.getUser();

      final request = GetUserNotificationRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
      );
      final response = await _api.getUserNotification(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveUserDevice() {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();

      final model = await getDeviceModel();
      final token = await getToken();

      final request = InsertUserDeviceRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        dispositivo: model,
        token: token,
      );
      await _api.saveUserDevice(request);
      return true;
    });
  }

  Future<String> getToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();

      if (token == null) {
        throw const ResultException(
          'Error al obtener el token del dispositivo',
        );
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getDeviceModel() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.brand + androidInfo.model + androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.machine;
      } else {
        throw const ResultException(
          'Error al obtener el nombre del dispositivo',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Result<bool, Failure>> saveUserAlert({
    required List<int> idAlerta,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = InsertUserAlertRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        idAlerta: idAlerta,
      );
      await _api.saveUserAlert(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> saveUserNotification({
    required List<int> idNotificacion,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = InsertUserNotificationRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        idNotificacion: idNotificacion,
      );
      await _api.saveUserNotification(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateUserDevice({
    required int idUsuarioDispositivo,
    required String dispositivo,
    required String token,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = UpdateUserDeviceRequest(
        idCompania: user.idCompany,
        idUsuarioDispositivo: idUsuarioDispositivo,
        idUsuario: user.idEmployee,
        dispositivo: dispositivo,
        token: token,
      );
      await _api.updateUserDevice(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateUserAlert({
    required List<int> idAlerta,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = UpdateUserAlertRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        idAlerta: idAlerta,
      );
      await _api.updateUserAlert(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateUserNotification({
    required List<int> idNotificacion,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = UpdateUserNotificationRequest(
        idCompania: user.idCompany,
        idNotificacion: idNotificacion,
        idUsuario: user.idEmployee,
      );
      await _api.updateUserNotification(request);
      return true;
    });
  }
}
