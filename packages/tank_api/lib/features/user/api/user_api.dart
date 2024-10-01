import 'package:failures/failures.dart';
import 'package:tank_api/core/extends/json_extends.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/user/models/user_request.dart';

class UserApi extends BaseApi {
  Future<void> getUserToSignIn(
    SignInUserRequest insertUserRequest,
  ) async {
    try {
      final response = await post(
        insertUserRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
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
