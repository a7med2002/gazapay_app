import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;
  final bool isLoading;
  final bool isEnabled;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.title,
    this.child,
    this.isLoading = false,
    this.isEnabled = true,
    this.height = 55,
    this.borderRadius = 14,
    this.backgroundColor,
    this.textColor = kWhiteColor,
  }) : assert(
         title != null || child != null,
         "You must provide either title or child",
       );

  @override
  Widget build(BuildContext context) {
    final bool disabled = !isEnabled || isLoading;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? kPrimaryColor,
          disabledBackgroundColor: (backgroundColor ?? kPrimaryColor)
              .withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(kWhiteColor),
                ),
              )
            : child ??
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
      ),
    );
  }
}
