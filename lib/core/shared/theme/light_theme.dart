import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_application/core/shared/theme/shape.dart';

ColorScheme colorScheme = ColorScheme.fromSwatch(
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFAFAFAF),
);

ThemeData lightTheme = ThemeData(
  colorScheme: colorScheme,
  primaryColor: const Color(0xFF000000),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0x6D6BFF),
  ),
  textTheme: GoogleFonts.shadowsIntoLightTextTheme(),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: const MaterialStatePropertyAll(
        Size(double.infinity, 20),
      ),
      shape: MaterialStatePropertyAll(Shapes.rec),
    ),
  ),
);
