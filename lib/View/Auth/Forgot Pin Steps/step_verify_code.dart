import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Widgets/otp_field.dart';
import '../../../widgets/primary_button.dart';

class StepVerifyCode extends StatelessWidget {
  final VoidCallback onNext;

  const StepVerifyCode({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Title
          const Text(
            "التحقق من الرقم",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          /// Subtitle
          const Text(
            "تم إرسال رمز التحقق إلى +970",
            style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          /// OTP
          const OtpField(),
          const SizedBox(height: 20),

          /// Timer
          const Text(
            "انتهاء صلاحية الرمز بعد 3:00",
            style: TextStyle(
              fontSize: 13,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          /// Verify Button
          PrimaryButton(title: "تحقق", onPressed: onNext),

          const SizedBox(height: 16),

          /// Resend
          GestureDetector(
            onTap: () {},
            child: const Text(
              "إعادة إرسال الرمز",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1E3A5F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
