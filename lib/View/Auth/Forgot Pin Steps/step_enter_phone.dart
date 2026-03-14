import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Provider/forgot_pin_provider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/custom_text_filed.dart';

class StepEnterPhone extends StatelessWidget {
  final VoidCallback onNext;

  const StepEnterPhone({super.key, required this.onNext});

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

            CustomTextField(
              hint: "+970",
              keyboardType: TextInputType.phone,
              prefixSvg: "assets/icons/phone.svg",
              controller: provider.phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرقم مطلوب";
                }
                if (!value.startsWith("+970") && !value.startsWith("+972")) {
                  return "يجب أن يبدأ الرقم بـ +970 أو +972";
                }
                if (value.startsWith("+970") && value.length != 13) {
                  return "رقم الهاتف غير صحيح (+970xxxxxxxx)";
                }
                if (value.startsWith("+972") && value.length != 13) {
                  return "رقم الهاتف غير صحيح (+972xxxxxxxx)";
                }
                final digits = value.substring(1);
                if (!RegExp(r'^\d+$').hasMatch(digits)) {
                  return "رقم الهاتف يحتوي على رموز غير صحيحة";
                }
                return null; // صح
              },
            ),

            const SizedBox(height: 30),

            Consumer<ForgotPinProvider>(
              builder: (_, forgotPinProv, _) {
                if (forgotPinProv.resetPinResponse?.status == Status.LOADING) {
                  return const CircularProgressIndicator();
                }
                if (forgotPinProv.resetPinResponse?.status ==
                    Status.COMPLETED) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("تم إرسال رمز التحقق إلى هاتفك"),
                        backgroundColor: kPrimaryColor,
                      ),
                    );
                    onNext();
                  });
                }
                if (forgotPinProv.resetPinResponse?.status == Status.ERROR) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          forgotPinProv.resetPinResponse?.message ?? "حدث خطأ",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                }
                return PrimaryButton(
                  title: "إرسال رمز التحقق",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      forgotPinProv.resetPin();
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
