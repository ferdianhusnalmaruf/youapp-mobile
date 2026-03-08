import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

class YouappDropdownWidget<T> extends StatelessWidget {
  const YouappDropdownWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.labelText,
    this.hintText,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?) onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      dropdownColor: headerCardBackgroundColor,
      focusColor: headerCardBackgroundColor,
      style: cTextRegXS.copyWith(color: primaryColor),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        hoverColor: headerCardBackgroundColor,
        focusColor: headerCardBackgroundColor,
        fillColor: headerCardBackgroundColor,
        labelStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        hintStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
    );
  }
}
