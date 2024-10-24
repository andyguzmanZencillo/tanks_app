import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/notification/entity/alert_entity.dart';
import 'package:tank_repository/features/notification/entity/notification_entity.dart';
import 'package:tank_repository/features/notification/map/alert_response_to_entity.dart';
import 'package:tank_repository/features/notification/map/notification_response_to_entity.dart';

class NotificationRepository {
  NotificationRepository({
    NotificationApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? NotificationApi();

  final NotificationApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<AlertEntity>, Failure>> getAlerts() {
    return handleExceptionCompleteToken<List<AlertEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetAlertRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getAlerts(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<NotificationEntity>, Failure>> getNotifications() {
    return handleExceptionCompleteToken<List<NotificationEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetNotificationRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getNotifications(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> save({
    required List<int> idAlerta,
    required List<int> idNotificacion,
  }) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = InserNotificationMultiRequest(
        idCompania: user.idCompany,
        idUsuario: user.idEmployee,
        idAlerta: idAlerta,
        idNotificacion: idNotificacion,
      );
      await _api.save(request);
      return true;
    });
  }
}
