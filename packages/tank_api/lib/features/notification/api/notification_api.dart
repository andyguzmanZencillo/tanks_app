import 'package:failures/failures.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/notification/notification.dart';

class NotificationApi extends BaseApi {
  Future<List<NotificationResponse>> getNotifications(
    GetNotificationRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => NotificationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AlertResponse>> getAlerts(
    GetAlertRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => AlertResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> save(
    InserNotificationMultiRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }
}
