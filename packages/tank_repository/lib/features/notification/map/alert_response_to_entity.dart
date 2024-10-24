import 'package:tank_api/features/notification/models/alert_response.dart';
import 'package:tank_repository/features/notification/notification.dart';

extension MapperAlertResponseToEntity on AlertResponse {
  AlertEntity toEntity() {
    return AlertEntity(
      descripcion: descripcion,
      idCompania: idCompania,
      idAlerta: idAlerta,
      nombreAlerta: nombreAlerta,
    );
  }
}
