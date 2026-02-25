import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Widgets/success_dialog.dart';
import '../../../widgets/custom_text_filed.dart';
import '../../../widgets/primary_button.dart';

class StepCreatePin extends StatelessWidget {
  final VoidCallback onNext;

  const StepCreatePin({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "إنشاء رمز جديد",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text(
            "أدخل رمز PIN الجديد",
            style: TextStyle(fontSize: 14, color: kGreyColor),
          ),

          const SizedBox(height: 30),

          const Align(
            alignment: Alignment.centerRight,
            child: Text("رمز PIN الجديد"),
          ),
          const SizedBox(height: 8),

          const CustomTextField(
            hint: "ادخل 4-6 أرقام",
            keyboardType: TextInputType.number,
            obscureText: true,
            prefixSvg: "assets/icons/lock.svg",
          ),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerRight,
            child: Text("تأكيد رمز PIN الجديد"),
          ),
          const SizedBox(height: 8),

          const CustomTextField(
            hint: "أعد ادخال الرمز",
            keyboardType: TextInputType.number,
            obscureText: true,
            prefixSvg: "assets/icons/lock.svg",
          ),

          const SizedBox(height: 30),

          PrimaryButton(
            title: "تغيير الرمز",
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: kWhiteColor.withOpacity(0.8),
                builder: (_) => const SuccessDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
