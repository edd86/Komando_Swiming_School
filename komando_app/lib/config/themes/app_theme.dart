import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF049BAE);
  static const Color secondaryColor = Color(0xFFC3FCF2);
  static const Color highlightColor = Color(0xFFF9F871);
  static const Color softColor = Color(0xFF436089);
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
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.robotoCondensed(
            fontSize: 16,
            color: shadowColor,
          ),
        ),
        iconTheme: const IconThemeData(color: softColor),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(highlightColor),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.robotoCondensed(
            color: shadowColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.highlightColor,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondaryColor),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(primaryColor),
            foregroundColor: const MaterialStatePropertyAll(secondaryColor),
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: softColor,
          contentTextStyle: GoogleFonts.robotoCondensed(color: secondaryColor),
        ),
        cardTheme: const CardTheme(
            color: softColor, shadowColor: shadowColor, elevation: 5),
        listTileTheme: ListTileThemeData(
          tileColor: primaryColor,
          iconColor: highlightColor,
          titleTextStyle: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: secondaryColor,
          ),
          subtitleTextStyle: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: secondaryColor,
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.robotoCondensed(fontWeight: FontWeight.w700),
            ),
            backgroundColor: const MaterialStatePropertyAll(primaryColor),
            foregroundColor: const MaterialStatePropertyAll(highlightColor),
            shadowColor:const MaterialStatePropertyAll(shadowColor),
            elevation:const MaterialStatePropertyAll(5),
            overlayColor:const MaterialStatePropertyAll(highlightColor),
            iconColor: const MaterialStatePropertyAll(secondaryColor)
          ),
        ),
        dividerColor: softColor,
      ));
}
