import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

class YouappTextFormFieldWidget extends StatelessWidget {
  const YouappTextFormFieldWidget({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.isReadonly = false,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final bool isReadonly;
  final TextInputType? keyboardType;

  /// NEW
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isReadonly,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        filled: isReadonly,
        fillColor: isReadonly ? colorWhiteOpc06 : null,
        labelStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        hintStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        errorStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
