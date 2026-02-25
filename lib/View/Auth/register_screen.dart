import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/assets.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/View/Auth/login_screen.dart';
import 'package:gazapay/Widgets/custom_text_filed.dart';
import 'package:gazapay/Widgets/logo_with_title.dart';
import 'package:gazapay/Widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  static String id = "registerScreen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            /// Top Background Shape
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(authScreenShape, fit: BoxFit.cover),
            ),

            /// Content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  /// Logo & Title
                  LogoWithTitle(),
                  const SizedBox(height: 100),

                  // Title
                  const Text(
                    "إنشاء حساب جديد",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// Full Name
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الاسم الكامل",
                      style: TextStyle(fontSize: 14, color: kBlackColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "ادخل الاسم رباعي",
                    prefixSvg: "assets/icons/user.svg",
                  ),
                  const SizedBox(height: 20),

                  /// Phone
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "رقم الهاتف",
                      style: TextStyle(fontSize: 14, color: kBlackColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "+970",
                    prefixSvg: "assets/icons/phone.svg",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  /// PIN
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "رمز PIN",
                      style: TextStyle(fontSize: 14, color: kBlackColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "ادخل 4-6 أرقام",
                    prefixSvg: "assets/icons/lock.svg",
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),

                  /// Confirm PIN
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تأكيد رمز PIN",
                      style: TextStyle(fontSize: 14, color: kBlackColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "أعد ادخال الرمز",
                    prefixSvg: "assets/icons/lock.svg",
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 40),

                  /// Continue Button
                  PrimaryButton(onPressed: () {}, title: "متابعة"),
                  const SizedBox(height: 20),

                  /// Login Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "لديك حساب بالفعل ؟ ",
                        style: TextStyle(fontSize: 14, color: kGreyColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
                        },
                        child: const Text(
                          "تسجيل دخول",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
