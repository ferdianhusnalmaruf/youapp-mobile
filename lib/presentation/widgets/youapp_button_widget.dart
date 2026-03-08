import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

class YouAppButtonWidget extends StatelessWidget {
  const YouAppButtonWidget({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: onPressed == null
            ? buttonLinearGradient.withOpacity(0.3)
            : buttonLinearGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: onPressed == null
            ? null
            : [
                BoxShadow(
                  color: buttonLinearGradient.colors.first,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          label,
          style: cTextBold.copyWith(
            color: onPressed == null
                ? primaryColor.withOpacity(0.3)
                : primaryColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
