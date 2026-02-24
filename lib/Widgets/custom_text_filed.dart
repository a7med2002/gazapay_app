import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazapay/Core/Util/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;

  /// Icons
  final String? prefixSvg;
  final String? suffixSvg;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixSvg,
    this.suffixSvg,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kGreyColor),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),

        /// Borders
        border: _border(kHintColor),
        enabledBorder: _border(kHintColor),
        focusedBorder: _border(kPrimaryColor, width: 1.2),

        /// Prefix
        prefixIcon:
            prefixIcon ??
            (prefixSvg != null
                ? Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      prefixSvg!,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        kGreyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null),

        /// Suffix
        suffixIcon:
            suffixIcon ??
            (suffixSvg != null
                ? Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      suffixSvg!,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        kGreyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
