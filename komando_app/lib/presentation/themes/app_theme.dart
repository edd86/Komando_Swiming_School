import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF049BAE);
  static const Color secondaryColor = Color(0xFFF3FDFF);
  static const Color highlightColor = Color(0xFF7BD75B);
  static const Color brightColor = Color(0xFFFFDE59);
  static const Color shadowColor = Color(0xFF3F3B3B);

  static const BorderRadius radius = BorderRadius.all(Radius.circular(25));

  static ThemeData themeKomandoApp(BuildContext context) =>
      (ThemeData.light().copyWith(
        primaryColor: primaryColor,
        highlightColor: highlightColor,
        shadowColor: shadowColor,
        scaffoldBackgroundColor: secondaryColor,
        appBarTheme: AppBarTheme(
            color: primaryColor,
            foregroundColor: secondaryColor,
            elevation: 5,
            shadowColor: shadowColor,
            titleTextStyle: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.bold, fontSize: 23)),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.robotoCondensed(
            fontSize: 16,
            color: shadowColor,
          ),
        ),
      ));
}
