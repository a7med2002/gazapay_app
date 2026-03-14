import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Repo/user_repository.dart';

class ForgotPinProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  ApiResponse<String>? resetPinResponse;

  ApiResponse<String>? verifyCodeResponse;

  ApiResponse<String>? changePinResponse;

  String? resetToken;

  Future<void> resetPin() async {
    resetPinResponse = ApiResponse.loading("Resetting PIN...");
    notifyListeners();

    try {
      final message = await _repository.resetPin({
        "phone": phoneController.text,
      });
      resetPinResponse = ApiResponse.completed(message);
    } catch (e) {
      resetPinResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> verifyCode() async {
    verifyCodeResponse = ApiResponse.loading("loading...");
    notifyListeners();
    print(
      "Verifying code for phone: ${phoneController.text} with code: ${codeController.text}",
    );
    try {
      final token = await _repository.verifyCode({
        "phone": phoneController.text,
        "code": codeController.text,
      });

      resetToken = token;
      verifyCodeResponse = ApiResponse.completed(token);
    } catch (e) {
      verifyCodeResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }

  Future<void> changePin() async {
    if (resetToken == null) {
      changePinResponse = ApiResponse.error(
        "Invalid token. Please verify code first.",
      );
      notifyListeners();
      return;
    }

    changePinResponse = ApiResponse.loading("Changing PIN...");
    notifyListeners();

    try {
      final message = await _repository.changePin({
        "phone": phoneController.text,
        "newPassword": newPinController.text,
      }, resetToken!);

      changePinResponse = ApiResponse.completed(message);
    } catch (e) {
      changePinResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
