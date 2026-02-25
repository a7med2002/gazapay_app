import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/View/Auth/login_screen.dart';
import '../../../widgets/primary_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 25,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/icons/success.svg", width: 60, height: 60),
            const SizedBox(height: 16),
            const Text(
              "تم تغيير الرمز بنجاح",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "يمكنك الآن تسجيل الدخول بالرمز الجديد",
              textAlign: TextAlign.center,
              style: TextStyle(color: kBlackColor),
            ),

            const SizedBox(height: 24),
            PrimaryButton(
              title: "تسجيل الدخول",
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
