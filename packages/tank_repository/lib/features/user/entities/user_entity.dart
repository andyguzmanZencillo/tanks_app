import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.idCompany,
    required this.idEmployee,
    required this.login,
    required this.password,
    required this.name,
    required this.idIsar,
  });

  const UserEntity.empty()
      : idCompany = 0,
        idEmployee = 0,
        login = '',
        password = '',
        name = '',
        idIsar = 0;

  final int idIsar;
  final int idCompany;
  final int idEmployee;
  final String login;
  final String password;
  final String name;

  UserEntity copyWith({
    int? idIsar,
    int? idCompany,
    int? idEmployee,
    String? login,
    String? password,
    String? name,
  }) {
    return UserEntity(
      idIsar: idIsar ?? this.idIsar,
      idCompany: idCompany ?? this.idCompany,
      idEmployee: idEmployee ?? this.idEmployee,
      login: login ?? this.login,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [
        idIsar,
        idCompany,
        idEmployee,
        login,
        password,
        name,
      ];
}
