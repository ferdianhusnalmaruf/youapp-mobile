import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

class YouAppInfoAboutUserWidget extends StatelessWidget {
  const YouAppInfoAboutUserWidget({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: cTextMedXS.copyWith(color: colorWhiteOpc33)),
        SizedBox(width: 8),
        Text(value, style: cTextMedXS),
      ],
    );
  }
}
