import 'package:flutter/material.dart';
import 'package:gazapay/Core/Util/constants.dart';

class OtpField extends StatefulWidget {
  final Function(String) onCompleted;

  const OtpField({super.key, required this.onCompleted});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    /// جمع الكود
    String code = controllers.map((e) => e.text).join();

    if (code.length == 6) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: kWhiteColor,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: kHintColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: kHintColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
              ),
            ),
            onChanged: (value) => onChanged(value, index),
          ),
        ),
      ),
    );
  }
}
