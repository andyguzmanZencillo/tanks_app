import 'dart:convert';
import 'dart:developer';

import 'package:tank_api/core/encryption/encryption.dart';

class TokenRequest {
  TokenRequest({
    required this.idCompany,
    required this.user,
    required this.password,
  });
  String encrypt(String data) {
    return Encryption.encrypt(data);
  }

  String decrypt(String data) {
    return Encryption.decrypt(data);
  }

  final String idCompany;
  final String user;
  final String password;

  Map<String, dynamic> toJson() {
    final json = {
      'token_command': {
        'idcompany': int.parse(idCompany),
        'user': user,
        'password': password,
      },
    };

    log('REQUEST TOKEN ===> ${jsonEncode(json)}');
    final jsonDone = {
      'token_command': encrypt(
        jsonEncode({
          'idcompany': int.parse(idCompany),
          'user': user,
          'password': password,
        }),
      ),
    };
    log('ENCRYPTED TOKEN ===> $jsonDone)}');
    return jsonDone;
  }
}
