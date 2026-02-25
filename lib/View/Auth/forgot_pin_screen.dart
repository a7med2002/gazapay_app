import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:gazapay/View/Auth/Forgot%20Pin%20Steps/step_create_pin.dart';
import 'package:gazapay/View/Auth/Forgot%20Pin%20Steps/step_enter_phone.dart';
import 'package:gazapay/View/Auth/Forgot%20Pin%20Steps/step_verify_code.dart';
import 'package:gazapay/Widgets/forgot_pin_header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ForgotPinScreen extends StatefulWidget {
  static String id = "forgotPinScreen";
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  final PageController _controller = PageController();

  void next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const ForgotPinHeader(),

            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StepEnterPhone(onNext: next),
                  StepVerifyCode(onNext: next),
                  StepCreatePin(onNext: next),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 8,
                  activeDotColor: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
