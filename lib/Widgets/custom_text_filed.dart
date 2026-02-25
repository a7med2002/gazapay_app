import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazapay/Core/Util/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;

  /// Core
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType keyboardType;

  /// Validation
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  /// Icons
  final String? prefixSvg;
  final String? suffixSvg;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.prefixSvg,
    this.suffixSvg,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
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
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red, width: 1.2),

        /// Prefix
        prefixIcon: prefixIcon ??
            (prefixSvg != null
                ? _buildSvg(prefixSvg!)
                : null),

        /// Suffix
        suffixIcon: suffixIcon ??
            (suffixSvg != null
                ? _buildSvg(suffixSvg!)
                : null),
      ),
    );
  }

  Widget _buildSvg(String path) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: SvgPicture.asset(
        path,
        height: 20,
        width: 20,
        colorFilter:
            const ColorFilter.mode(kGreyColor, BlendMode.srcIn),
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