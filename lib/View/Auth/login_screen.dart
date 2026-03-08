import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Core/Util/assets.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Provider/login_provider.dart';
import 'package:gazapay/View/Auth/forgot_pin_screen.dart';
import 'package:gazapay/View/Auth/register_screen.dart';
import 'package:gazapay/View/Home/home_screen.dart';
import 'package:gazapay/Widgets/custom_text_filed.dart';
import 'package:gazapay/Widgets/logo_with_title.dart';
import 'package:gazapay/Widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = "loginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProv = Provider.of<LoginProvider>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),

                    /// Logo
                    const LogoWithTitle(),
                    const SizedBox(height: 100),

                    /// Welcome Text
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "مرحباً بعودتك ..",
                        style: TextStyle(fontSize: 14, color: kPrimaryColor),
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Title
                    const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 40),

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "يرجى إدخال رقم الهاتف";
                        }
                        return null;
                      },
                      controller: loginProv.phoneController,
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
                      suffixSvg: "assets/icons/eye.svg",
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: loginProv.pinController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "يرجى إدخال رمز PIN";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    /// Forgot PIN
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ForgotPinScreen.id);
                        },
                        child: const Text(
                          "نسيت رمز PIN؟",
                          style: TextStyle(
                            fontSize: 13,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Login Button
                    Consumer<LoginProvider>(
                      builder: (_, loginProv, _) {
                        if (loginProv.loginResponse?.status == Status.LOADING) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (loginProv.loginResponse?.status == Status.ERROR) {
                          print("Error: ${loginProv.loginResponse?.message}");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (loginProv.loginResponse?.message != null &&
                                loginProv.loginResponse!.message!.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    loginProv.loginResponse!.message!,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                ),
                              );
                            }
                          });
                        }
                        if (loginProv.loginResponse?.status ==
                            Status.COMPLETED) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.id,
                            );
                          });
                        }
                        return PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginProv.login();
                            }
                          },
                          title: "تسجيل الدخول",
                        );
                      },
                    ),
                    const SizedBox(height: 30),

                    /// Divider with OR
                    Row(
                      children: const [
                        Expanded(child: Divider(color: kHintColor)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "أو",
                            style: TextStyle(color: kGreyColor),
                          ),
                        ),
                        Expanded(child: Divider(color: kHintColor)),
                      ],
                    ),
                    const SizedBox(height: 25),

                    /// Biometric Login Text
                    const Text(
                      "تسجيل الدخول بالبصمة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Fingerprint Button
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/fingerprint.svg",
                          height: 40,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Register Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "ليس لديك حساب؟ ",
                          style: TextStyle(fontSize: 14, color: kGreyColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RegisterScreen.id,
                            );
                          },
                          child: const Text(
                            "إنشاء حساب جديد",
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
            ),
          ],
        ),
      ),
    );
  }
}
