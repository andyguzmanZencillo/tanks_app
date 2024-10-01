class UserEntity {
  UserEntity({
    required this.idCompany,
    required this.idEmployee,
    required this.login,
    required this.password,
    required this.name,
    required this.idIsar,
  });

  final int idIsar;
  final int idCompany;
  final int idEmployee;
  final String login;
  final String password;
  final String name;
}
