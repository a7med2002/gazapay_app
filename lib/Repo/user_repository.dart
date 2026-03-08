import 'package:gazapay/Core/Helper/api_base_helper.dart';
import 'package:gazapay/Model/login_response.dart';
import 'package:gazapay/Model/user.dart';

class UserRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> register(Map<String, dynamic> data) async {
    final response = await _helper.post("/auth/register", data, {
      "Content-Type": "application/json",
    });
    return User.fromJson(response);
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    final response = await _helper.post("/auth/login", data, {
      "Content-Type": "application/json",
    });
    return LoginResponse.fromJson(response);
  }
}
