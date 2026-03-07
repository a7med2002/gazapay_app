import 'package:gazapay/Core/Helper/api_base_helper.dart';
import 'package:gazapay/Model/user.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> register(Map<String, dynamic> data) async {
    final response = await _helper.post("/auth/register", data, {
      "Content-Type": "application/json",
    });
    return User.fromJson(response);
  }
}
