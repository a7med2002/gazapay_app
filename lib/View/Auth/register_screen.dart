import 'package:flutter/material.dart';
import 'package:gazapay/Core/Helper/api_response.dart';
import 'package:gazapay/Core/Util/assets.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/Provider/register_provider.dart';
import 'package:gazapay/View/Auth/login_screen.dart';
import 'package:gazapay/View/Home/home_screen.dart';
import 'package:gazapay/Widgets/custom_text_filed.dart';
import 'package:gazapay/Widgets/logo_with_title.dart';
import 'package:gazapay/Widgets/primary_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static String id = "registerScreen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final provider = Provider.of<RegisterProvider>(context);
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
                      controller: provider.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الاسم مطلوب";
                        }
                        return null;
                      },
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
                      controller: provider.phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرقم مطلوب";
                        }
                        if (!value.startsWith("+970") &&
                            !value.startsWith("+972")) {
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
                      controller: provider.pinController,
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
                      controller: provider.confirmPinController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "تأكيد رمز PIN مطلوب";
                        }
                        if (value != provider.pinController.text) {
                          return "الرمز غير متطابق";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    /// Register Button
                    Consumer<RegisterProvider>(
                      builder: (_, registerProv, _) {
                        if (registerProv.registerResponse?.status ==
                            Status.LOADING) {
                          return const CircularProgressIndicator();
                        }
                        if (registerProv.registerResponse?.status ==
                            Status.ERROR) {
                          print(
                            "Error: ${registerProv.registerResponse?.message}",
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (registerProv.registerResponse?.message !=
                                    null &&
                                registerProv
                                    .registerResponse!
                                    .message!
                                    .isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    registerProv.registerResponse!.message!,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                ),
                              );
                            }
                          });
                        }
                        if (provider.registerResponse?.status ==
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
                              provider.register();
                            }
                          },
                          title: "متابعة",
                        );
                      },
                    ),
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
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            );
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
            ),
          ],
        ),
      ),
    );
  }
}
