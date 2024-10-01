import 'dart:convert';
import 'dart:developer';

class DefaultResponse {
  DefaultResponse({
    required this.response,
    required this.message,
    required this.result,
    this.token,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) {
    return DefaultResponse(
      response: json['Response'] as bool,
      message: json['Message'] as String,
      result: json['Result'] == null
          ? null
          : json['Result'] is int
              ? null
              : DefaultResult.fromJson(
                  json['Result'] as Map<String, dynamic>,
                ),
      token: json['Token'] as String?,
    );
  }

  final bool response;
  final String message;
  final DefaultResult? result;
  final String? token;
}

class DefaultResult {
  DefaultResult({
    required this.code,
    required this.exist,
    required this.message,
    required this.resultSP,
    required this.result,
  });

  factory DefaultResult.fromJson(Map<String, dynamic> json) {
    return DefaultResult(
      result: json['Result'] is int
          ? (json['Result'] as int) == 1
          : json['Result'] as bool?,
      code: json['Code'] is int
          ? (json['Code'] as int) == 1
          : json['Code'] is String
              ? int.parse(json['Code'] as String) == 1
              : json['Code'] as bool?,
      exist: json['Exist'] is bool
          ? json['Exist'] as bool
              ? 1 // 1 When true
              : 0 // 0 When False
          : json['Exist'] as int,
      message: json['Message'] is bool
          ? (json['Message'] as bool).toString()
          : json['Message'] as String,
      resultSP: json['ResultSP'],
    );
  }

  final bool? code;
  final int exist;
  final String message;
  final dynamic resultSP;
  final bool? result;
}

class DefaultResponse2 {
  DefaultResponse2({
    required this.response,
    required this.message,
    required this.result,
  });

  factory DefaultResponse2.fromJson(Map<String, dynamic> json) {
    return DefaultResponse2(
      response: json['Response'] as bool,
      message: json['Message'] as String?,
      result: json['Result'] == null
          ? null
          : json['Result'] as Map<String, dynamic>,
    );
  }

  final bool response;
  final String? message;
  final dynamic result;
}

/*class ResultSp {
  ResultSp({
    required this.exist,
    required this.result,
    required this.code,
    required this.message,
    required this.idNotaCredito,
    required this.numeroNC,
    required this.prefijoNC,
  });

  factory ResultSp.fromJson(Map<String, dynamic> json) {
    return ResultSp(
      exist: json['Exist'] as bool,
      result: json['Result'] as bool,
      code: json['Code'] as bool,
      message: json['Message'] as String,
      idNotaCredito: json['IdNotaCredito'] as int,
      numeroNC: json['NumeroNC'] as String,
      prefijoNC: json['PrefijoNC'] as String,
    );
  }

  final bool exist;
  final bool result;
  final bool code;
  final String message;
  final int idNotaCredito;
  final String numeroNC;
  final String prefijoNC;
}*/

class TokenResponse {
  TokenResponse({
    required this.response,
    required this.message,
    required this.token,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    final tokenResponseJson = json['token_response'] as Map<String, dynamic>;
    return TokenResponse(
      response: tokenResponseJson['response'] as bool,
      message: tokenResponseJson['message'] as String,
      token: tokenResponseJson['token'] as String,
    );
  }
  final bool response;
  final String message;
  final String token;
}

class ResultSp {
  ResultSp({
    required this.insertedId,
  });

  factory ResultSp.fromJson(Map<String, dynamic> json) {
    return ResultSp(
      insertedId: json['inserted_id'] as int,
    );
  }
  final int insertedId;

  Map<String, dynamic> toJson() {
    return {
      'inserted_id': insertedId,
    };
  }
}

class DataResponse {
  DataResponse({
    required this.message,
    required this.result,
    required this.resultSp,
  });
  factory DataResponse.fromJson(Map<String, dynamic> json) {
    dynamic validate(dynamic value) {
      if (value == null) {
        return null;
      } else if (value is List) {
        return value;
      } else {
        return value as Map<String, dynamic>;
      }
    }

    final data = jsonDecode(json['data'] as String) as Map<String, dynamic>;
    log(data.toString());
    return DataResponse(
      message: data['message'] as String,
      result: data['result'] as bool,
      resultSp: validate(data['resultsp']),
    );
  }

  void valid() {}
  final String message;
  final bool result;
  final dynamic resultSp;
}
