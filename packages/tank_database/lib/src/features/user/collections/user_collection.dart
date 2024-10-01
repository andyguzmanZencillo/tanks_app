import 'package:isar/isar.dart';

part 'user_collection.g.dart';

@collection
class UserCollection {
  UserCollection({
    required this.idCompany,
    required this.idEmployee,
    required this.login,
    required this.password,
    required this.name,
  });

  final Id id = Isar.autoIncrement;
  final int idCompany;
  final int idEmployee;
  final String login;
  final String password;
  final String name;
}
