import 'package:flutter/material.dart';

const primaryColor = Color(0xFFFFFFFF);

Color colorWhiteOpc40 = Color(0xFFFFFFFF).withOpacity(0.40);
Color colorWhiteOpc33 = Color(0xFFFFFFFF).withOpacity(0.33);
Color colorWhiteOpc52 = Color(0xFFFFFFFF).withOpacity(0.52);
Color colorWhiteOpc08 = Color(0xFFFFFFFF).withOpacity(0.08);
Color colorWhiteOpc06 = Color(0xFFFFFFFF).withOpacity(0.06);
Color colorWhiteOpc30 = Color(0xFFFFFFFF).withOpacity(0.30);

const backgroundRadialGradientColor = RadialGradient(
  center: Alignment(1.0, -1.0678),
  radius: 1.22,
  stops: [0.0, 0.5618, 1.0],
  colors: [Color(0xFF1F4247), Color(0xFF0D1D23), Color(0xFF09141A)],
);

const backgroundColor = Color(0xFF09141A);

const goldenColor = LinearGradient(
  colors: [
    Color(0xFF94783E),
    Color(0xFFF3EDA6),
    Color(0xFFF8FAE5),
    Color(0xFFFFE2BE),
    Color(0xFFD5BE88),
    Color(0xFFF8FAE5),
    Color(0xFFD5BE88),
  ],
);

const buttonLinearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF62CDCB), Color(0xFF4599DB)],
  stops: [0.2488, 0.7849],
);

const shadowImageLinearGradient = LinearGradient(
  colors: [Color(0xFF000000C2), Color(0xFF00000000), Color(0xFF000000)],
);

const childCardBackgroundColor = Color(0xFF0E191F);
const headerCardBackgroundColor = Color(0xFF162329);
