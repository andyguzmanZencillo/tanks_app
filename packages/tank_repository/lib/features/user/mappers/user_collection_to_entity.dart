import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/features/user/entities/user_entity.dart';

extension UserCollectionToEntity on UserCollection {
  UserEntity toEntity() {
    return UserEntity(
      idCompany: idCompany,
      idEmployee: idEmployee,
      login: login,
      password: password,
      name: name,
      idIsar: id,
    );
  }
}
