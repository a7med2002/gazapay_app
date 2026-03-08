import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Model/login_response.dart';
import 'package:gazapay/Repo/user_repository.dart';

class LoginProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  ApiResponse<LoginResponse>? _loginResponse;

  ApiResponse<LoginResponse>? get loginResponse => _loginResponse;

  Future<void> login() async {
    _loginResponse = ApiResponse.loading("Loading...");
    notifyListeners();
    try {
      final result = await _repository.login({
        "phone": phoneController.text,
        "password": pinController.text,
      });
      _loginResponse = ApiResponse.completed(result);
      notifyListeners();
    } catch (e) {
      _loginResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
