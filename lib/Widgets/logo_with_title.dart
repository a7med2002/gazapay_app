import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazapay/Core/Util/constants.dart';

class LogoWithTitle extends StatelessWidget {
  const LogoWithTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          "GAZA PAY",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kPrimaryColor,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 42,
          width: 42,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/appIcon.svg',
            color: kWhiteColor,
          ),
        ),
      ],
    );
  }
}
