import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/user/models/user_request.dart';

class UserApi extends BaseApi {
  void saveUser() {}

  Future<void> getUserToSignIn(
    SignInUserRequest insertUserRequest,
  ) async {
    try {
      await post(
        insertUserRequest.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertUser(
    InsertUserRequest insertUserRequest,
  ) async {
    try {
      await post(
        insertUserRequest.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
