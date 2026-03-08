import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

class YouappPasswordFormFieldWidget extends StatefulWidget {
  const YouappPasswordFormFieldWidget({
    super.key,
    required this.controller,
    this.suffixIcon,
    required this.labelText,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final String labelText;

  @override
  State<YouappPasswordFormFieldWidget> createState() =>
      _YouappPasswordFormFieldWidgetState();
}

class _YouappPasswordFormFieldWidgetState
    extends State<YouappPasswordFormFieldWidget> {
  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isDisabled = !isDisabled;
            });
          },
          icon: Icon(isDisabled ? Icons.visibility_off : Icons.visibility),
        ),
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        focusColor: colorWhiteOpc06,
      ),
      obscureText: isDisabled ? true : false,
    );
  }
}
