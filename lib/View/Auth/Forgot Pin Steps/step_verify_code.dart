import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Provider/forgot_pin_provider.dart';
import 'package:gazapay/Widgets/otp_field.dart';
import 'package:provider/provider.dart';
import '../../../widgets/primary_button.dart';

class StepVerifyCode extends StatelessWidget {
  final VoidCallback onNext;

  const StepVerifyCode({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ForgotPinProvider>();
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
          Text(
            "تم إرسال رمز التحقق إلى ${provider.phoneController.text.replaceRange(4, 10, "****")}",
            style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          /// OTP
          OtpField(
            onCompleted: (code) {
              context.read<ForgotPinProvider>().codeController.text = code;
            },
          ),
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
          Consumer<ForgotPinProvider>(
            builder: (_, prov, __) {
              if (prov.verifyCodeResponse?.status == Status.LOADING) {
                return const CircularProgressIndicator();
              }

              if (prov.verifyCodeResponse?.status == Status.COMPLETED) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onNext();
                });
              }

              if (prov.verifyCodeResponse?.status == Status.ERROR) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        prov.verifyCodeResponse?.message ?? "الكود غير صحيح",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              }

              return PrimaryButton(
                title: "تحقق",
                onPressed: () {
                  prov.verifyCode();
                },
              );
            },
          ),

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
