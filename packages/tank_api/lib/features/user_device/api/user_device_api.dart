import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/user_device/models/user_alert_request.dart';
import 'package:tank_api/features/user_device/models/user_alert_response.dart';
import 'package:tank_api/features/user_device/models/user_device_request.dart';
import 'package:tank_api/features/user_device/models/user_device_response.dart';
import 'package:tank_api/features/user_device/models/user_notification_request.dart';
import 'package:tank_api/features/user_device/models/user_notification_response.dart';

class UserDeviceApi extends BaseApi {
  Future<String> saveUserDevice(
    InsertUserDeviceRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> saveUserAlert(
    InsertUserAlertRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> saveUserNotification(
    InsertUserNotificationRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserDeviceResponse>> getUserDevice(
    GetUserDeviceRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => UserDeviceResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserAlertResponse>> getUserAlert(
    GetUserAlertRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => UserAlertResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserNotificationResponse>> getUserNotification(
    GetUserNotificationRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => UserNotificationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateUserDevice(
    UpdateUserDeviceRequest updateArticleRequest,
  ) async {
    try {
      final response = await post(
        updateArticleRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateUserAlert(
    UpdateUserAlertRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateUserNotification(
    UpdateUserNotificationRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
