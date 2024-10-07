import 'package:failures/failures.dart';
import 'package:tank_api/core/extends/json_extends.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/user/models/user_request.dart';
import 'package:tank_api/features/user/models/user_response.dart';

class UserApi extends BaseApi {
  Future<UserResponse> getUserToSignIn(
    SignInUserRequest insertUserRequest,
  ) async {
    try {
      final response = await post(
        insertUserRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      final list = response.resultSp as List;
      return list
          .map(
            (e) => UserResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList()
          .first;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insertUser(
    InsertUserRequest insertUserRequest,
  ) async {
    try {
      final response = await post(
        insertUserRequest.toJson(),
      );

      if (!response.result) throw ResultException(response.message);
      return (response.resultSp as Map<String, dynamic>).get('inserted_id', 0);
    } catch (e) {
      rethrow;
    }
  }
}
