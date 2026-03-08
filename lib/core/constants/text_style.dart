import 'package:flutter/material.dart';
import 'package:youapp/core/constants/colors.dart';

const TextStyle _textStyle = TextStyle(
  fontFamily: 'Inter',
  color: primaryColor,
);

final TextStyle _baseTextStyle2XS = _textStyle.copyWith(fontSize: 10);
final TextStyle _baseTextStyleXS = _textStyle.copyWith(fontSize: 12);
final TextStyle _baseTextStyleSM = _textStyle.copyWith(fontSize: 14);
final TextStyle _baseTextStyle = _textStyle.copyWith(fontSize: 16);
final TextStyle _baseTextStyleLg = _textStyle.copyWith(fontSize: 20);
final TextStyle _baseTextStyleXL = _textStyle.copyWith(fontSize: 24);
final TextStyle _baseTextStyle2XL = _textStyle.copyWith(fontSize: 32);
final TextStyle _baseTextStyle3XL = _textStyle.copyWith(fontSize: 40);

//REGULAR
final TextStyle _regularTextStyle = _textStyle.copyWith(
  fontWeight: FontWeight.w400,
);

final TextStyle cTextReg2XS = _baseTextStyle2XS.merge(_regularTextStyle);

final TextStyle cTextRegXS = _baseTextStyleXS.merge(_regularTextStyle);

final TextStyle cTextRegSM = _baseTextStyleSM.merge(_regularTextStyle);

final TextStyle cTextReg = _baseTextStyle.merge(_regularTextStyle);

final TextStyle cTextRegLg = _baseTextStyleLg.merge(_regularTextStyle);

final TextStyle cTextRegXL = _baseTextStyleXL.merge(_regularTextStyle);

final TextStyle cTextReg2XL = _baseTextStyle2XL.merge(_regularTextStyle);

final TextStyle cTextReg3XL = _baseTextStyle3XL.merge(_regularTextStyle);

//MEDIUM
final TextStyle _mediumTextStyle = _textStyle.copyWith(
  fontWeight: FontWeight.w500,
);

final TextStyle cTextMed2XS = _baseTextStyle2XS.merge(_mediumTextStyle);

final TextStyle cTextMedXS = _baseTextStyleXS.merge(_mediumTextStyle);

final TextStyle cTextMedSM = _baseTextStyleSM.merge(_mediumTextStyle);

final TextStyle cTextMed = _baseTextStyle.merge(_mediumTextStyle);

final TextStyle cTextMedLg = _baseTextStyleLg.merge(_mediumTextStyle);

final TextStyle cTextMedXL = _baseTextStyleXL.merge(_mediumTextStyle);

final TextStyle cTextMed2XL = _baseTextStyle2XL.merge(_mediumTextStyle);

final TextStyle cTextMed3XL = _baseTextStyle3XL.merge(_mediumTextStyle);

//BOLD
final TextStyle _boldTextStyle = _textStyle.copyWith(
  fontWeight: FontWeight.w700,
);

final TextStyle cTextBold2XS = _baseTextStyle2XS.merge(_boldTextStyle);

final TextStyle cTextBoldXS = _baseTextStyleXS.merge(_boldTextStyle);

final TextStyle cTextBoldSM = _baseTextStyleSM.merge(_boldTextStyle);

final TextStyle cTextBold = _baseTextStyle.merge(_boldTextStyle);

final TextStyle cTextBoldLg = _baseTextStyleLg.merge(_boldTextStyle);

final TextStyle cTextBoldXL = _baseTextStyleXL.merge(_boldTextStyle);

final TextStyle cTextBold2XL = _baseTextStyle2XL.merge(_boldTextStyle);

final TextStyle cTextBold3XL = _baseTextStyle3XL.merge(_boldTextStyle);
