import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';

class ForgotPinHeader extends StatelessWidget {
  const ForgotPinHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 24, color: kGreyColor),
          ),
          const Text(
            "استرجاع رمز PIN",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}
