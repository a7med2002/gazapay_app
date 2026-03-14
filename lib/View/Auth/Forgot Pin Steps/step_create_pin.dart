import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Provider/forgot_pin_provider.dart';
import 'package:gazapay/Widgets/success_dialog.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_text_filed.dart';
import '../../../widgets/primary_button.dart';

class StepCreatePin extends StatelessWidget {
  final VoidCallback onNext;

  const StepCreatePin({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final provider = context.watch<ForgotPinProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
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

            CustomTextField(
              hint: "ادخل الرمز 6 أرقام",
              keyboardType: TextInputType.number,
              obscureText: true,
              prefixSvg: "assets/icons/lock.svg",
              controller: provider.newPinController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرقم السري مطلوب";
                }
                if (value.length < 6) {
                  return "الرقم السري يجب أن يكون 6 أحرف على الأقل";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerRight,
              child: Text("تأكيد رمز PIN الجديد"),
            ),
            const SizedBox(height: 8),

            CustomTextField(
              hint: "أعد ادخال الرمز",
              keyboardType: TextInputType.number,
              obscureText: true,
              prefixSvg: "assets/icons/lock.svg",
              controller: provider.confirmPinController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "تأكيد رمز PIN مطلوب";
                }
                if (value != provider.newPinController.text) {
                  return "الرمز غير متطابق";
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            Consumer<ForgotPinProvider>(
              builder: (_, value, _) {
                if (value.changePinResponse?.status == Status.LOADING) {
                  return const CircularProgressIndicator();
                }
                if (value.changePinResponse?.status == Status.ERROR) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value.changePinResponse?.message ??
                              "حدث خطأ غير معروف",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                }
                if (provider.changePinResponse?.status == Status.COMPLETED) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: kWhiteColor.withOpacity(0.8),
                      builder: (_) => const SuccessDialog(),
                    );
                  });
                }
                return PrimaryButton(
                  title: "تغيير الرمز",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.changePin();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
