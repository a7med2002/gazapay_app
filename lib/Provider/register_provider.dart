import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Model/user.dart';
import 'package:gazapay/Repo/user_repository.dart';

class RegisterProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  ApiResponse<User>? _registerResponse;

  ApiResponse<User>? get registerResponse => _registerResponse;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();

  bool isLoading = false;

  Future<User?> register() async {
    if (pinController.text != confirmPinController.text) {
      _registerResponse = ApiResponse.error("رمز PIN غير متطابق");
      notifyListeners();
      return null;
    }

    isLoading = true;
    notifyListeners();

    try {
      final resultUser = await _userRepository.register({
        "name": nameController.text,
        "phone": phoneController.text,
        "password": pinController.text,
      });
      _registerResponse = ApiResponse.completed(resultUser);
      return resultUser;
    } catch (e) {
      _registerResponse = ApiResponse.error(e.toString());
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    pinController.clear();
    confirmPinController.clear();
  }
}
