import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';

final ThemeData cTheme = ThemeData(
  primaryColor: primaryColor,
  focusColor: primaryColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle: cTextReg,
    centerTitle: false,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
  ).copyWith(onPrimary: primaryColor, secondary: colorWhiteOpc52),
  primaryTextTheme: TextTheme(
    displayLarge: cTextBold2XL,
    displayMedium: cTextMed2XL,
    displaySmall: cTextReg2XL,
    headlineLarge: cTextBoldXL,
    headlineMedium: cTextMedXL,
    headlineSmall: cTextRegXL,
    titleLarge: cTextBoldLg,
    titleMedium: cTextMedLg,
    titleSmall: cTextRegLg,
    bodyLarge: cTextBold,
    bodyMedium: cTextMed,
    bodySmall: cTextReg,
    labelLarge: cTextBoldSM,
    labelMedium: cTextMedSM,
    labelSmall: cTextRegSM,
  ),
  textTheme: TextTheme(
    displayLarge: cTextBold2XL,
    displayMedium: cTextMed2XL,
    displaySmall: cTextReg2XL,
    headlineLarge: cTextBoldXL,
    headlineMedium: cTextMedXL,
    headlineSmall: cTextRegXL,
    titleLarge: cTextBoldLg,
    titleMedium: cTextMedLg,
    titleSmall: cTextRegLg,
    bodyLarge: cTextBold,
    bodyMedium: cTextMed,
    bodySmall: cTextReg,
    labelLarge: cTextBoldSM,
    labelMedium: cTextMedSM,
    labelSmall: cTextRegSM,
  ),
);
