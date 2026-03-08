import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:intl/intl.dart';

class YouappDatePickerFieldWidget extends StatelessWidget {
  const YouappDatePickerFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onDateSelected;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: primaryColor,
              surface: headerCardBackgroundColor,
            ),
            dialogBackgroundColor: headerCardBackgroundColor,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      if (onDateSelected != null) {
        onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      style: cTextRegXS.copyWith(color: primaryColor),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        labelStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        hintStyle: cTextRegXS.copyWith(color: colorWhiteOpc40),
        suffixIcon: const Icon(
          Icons.calendar_today,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
