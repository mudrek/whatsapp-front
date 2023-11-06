import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeDark {
  static final whatsappThemeDark = ThemeData.dark().copyWith(
      textTheme: TextTheme(
    displayLarge: GoogleFonts.robotoSlab(),
    displayMedium: GoogleFonts.robotoSlab(),
    displaySmall: GoogleFonts.robotoSlab(),
    bodyLarge: GoogleFonts.robotoSlab(),
    bodyMedium: GoogleFonts.robotoSlab(),
    bodySmall: GoogleFonts.robotoSlab(),
    titleLarge: GoogleFonts.robotoSlab(),
    titleMedium: GoogleFonts.robotoSlab(),
    titleSmall: GoogleFonts.robotoSlab(),
  ));
}
