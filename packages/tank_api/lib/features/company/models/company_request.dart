import 'dart:convert';
import 'dart:developer';

import 'package:tank_api/core/encryption/encryption.dart';
import 'package:tank_api/features/user/models/user_request.dart';

class RequestBase {
  RequestBase({
    required this.query,
    this.transactionFather = '100',
  });
  final String query;
  final String transactionFather;

  String encrypt(String data) {
    return Encryption.encrypt(data);
  }

  String decrypt(String data) {
    return Encryption.decrypt(data);
  }

  Map<String, dynamic> toJsonParams(Map<String, dynamic> content) {
    final json = <String, dynamic>{
      'transaction': transactionFather,
      'content': {
        'transaction': transactionFather,
        'content': {
          'query': query,
          'parameters': content,
        },
      },
    };
    //final query = (content['content'] as Map<String, dynamic>)['query'];
    log('REQUEST $query ===> ${jsonEncode(json)}');

    final jsonDone = <String, dynamic>{
      'transaction': transactionFather,
      'content': encrypt(
        jsonEncode(
          {
            'transaction': transactionFather,
            'content': {
              'query': query,
              'parameters': content,
            },
          },
        ),
      ),
    };
    log('ENCRYPTED $query ===> $jsonDone)}');
    return jsonDone;
  }
}

class CompanyRequest extends RequestBase {
  CompanyRequest({
    required this.operation,
    this.idUserTrace = 123,
    super.query = 'FNZSTanques_crud_compania',
  });

  final int idUserTrace;
  final String operation;

  Map<String, dynamic> _toJson(Map<String, dynamic> params) {
    final json = <String, dynamic>{
      'parameters': {
        'id_user_trace': idUserTrace,
        'operation': operation,
        ...params,
      },
    };

    return super.toJsonParams(json);
  }
}

class InsertCompanyRequest extends CompanyRequest {
  InsertCompanyRequest({
    required this.descripcion,
    this.codigo = 'C001',
  }) : super(
          operation: 'I',
        );

  final String descripcion;
  final String codigo;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'descripcion': descripcion,
      'codigo': codigo,
    };
    return super._toJson(json);
  }
}

class UpdateCompanyRequest extends CompanyRequest {
  UpdateCompanyRequest({
    required this.descripcion,
    required this.idCompania,
    this.codigo = 'C002',
  }) : super(
          operation: 'U',
        );

  final String descripcion;
  final String codigo;
  final int idCompania;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'codigo': codigo,
      'descripcion': descripcion,
      'id_compania': idCompania,
    };
    return super._toJson(json);
  }
}

class SelectCompanyRequest extends CompanyRequest {
  SelectCompanyRequest({
    required this.descripcion,
    required this.idCompania,
    this.codigo = 'C002',
  }) : super(
          operation: 'U',
        );

  final String descripcion;
  final String codigo;
  final int idCompania;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'codigo': codigo,
      'descripcion': descripcion,
      'id_compania': idCompania,
    };
    return super._toJson(json);
  }
}

class Asdasd {
  void asdasds() {
    final s = InsertUserRequest(
      operation: 'operation',
      idCompania: 213,
      nombre: 'nombre',
      clave: 'clave',
    );

    if (s.clave == 'asdasd') {
      final ss = s.idCompania;
    }
  }
}

//**{
     // "transaction": "100",
     // "content": {
     //    "query": "FNZSTanques_crud_usuario",
     //    "parameters": {
     //       "operation": "S",
     //       "nombre": "Juan P. Actualizado",
     //       "clave": "nuevaclave123"
     //    }
     // }
   //} */