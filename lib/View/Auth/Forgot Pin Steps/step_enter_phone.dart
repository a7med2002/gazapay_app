import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/custom_text_filed.dart';

class StepEnterPhone extends StatelessWidget {
  final VoidCallback onNext;

  const StepEnterPhone({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "نسيت رمز PIN ؟",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text(
            "ادخل رقم هاتفك لاعادة تعيين الرمز",
            style: TextStyle(fontSize: 14, color: kGreyColor),
          ),
          const SizedBox(height: 30),

          const Align(
            alignment: Alignment.centerRight,
            child: Text("رقم الهاتف"),
          ),
          const SizedBox(height: 8),

          const CustomTextField(
            hint: "+970",
            keyboardType: TextInputType.phone,
            prefixSvg: "assets/icons/phone.svg",
          ),

          const SizedBox(height: 30),

          PrimaryButton(title: "إرسال رمز التحقق", onPressed: onNext),
        ],
      ),
    );
  }
}
