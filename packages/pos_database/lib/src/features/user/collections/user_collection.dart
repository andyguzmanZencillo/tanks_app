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
    this.logged = false,
    this.date,
    this.id = Isar.autoIncrement,
  });

  final Id id;

  final int idCompany;
  final int idEmployee;
  final String login;
  final String password;
  final String name;
  bool logged;
  DateTime? date;
}
