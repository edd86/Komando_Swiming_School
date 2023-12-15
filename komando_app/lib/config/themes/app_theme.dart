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
        dialogTheme: DialogTheme(
          backgroundColor: primaryColor,
          iconColor: highlightColor,
          titleTextStyle: GoogleFonts.robotoCondensed(
            color: secondaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: GoogleFonts.robotoCondensed(
            color: secondaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: GoogleFonts.robotoCondensed(
                color: shadowColor, fontWeight: FontWeight.w700),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.softColor,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: softColor),
            ),
            iconColor: highlightColor),
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
              shadowColor: const MaterialStatePropertyAll(shadowColor),
              elevation: const MaterialStatePropertyAll(5),
              overlayColor: const MaterialStatePropertyAll(highlightColor),
              iconColor: const MaterialStatePropertyAll(secondaryColor)),
        ),
        dividerColor: softColor,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.robotoCondensed(color: secondaryColor),
            ),
          ),
        ),
        timePickerTheme: TimePickerThemeData(
            dayPeriodBorderSide: const BorderSide(color: softColor),
            cancelButtonStyle: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                GoogleFonts.robotoCondensed(
                  fontSize: 18,
                ),
              ),
              foregroundColor: const MaterialStatePropertyAll(secondaryColor),
            ),
            dialTextColor: softColor,
            dialTextStyle: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.w800,
            ),
            helpTextStyle: GoogleFonts.robotoCondensed(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
            ),
            confirmButtonStyle: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                GoogleFonts.robotoCondensed(
                  fontSize: 18,
                ),
              ),
              foregroundColor: const MaterialStatePropertyAll(secondaryColor),
            ),
            dayPeriodTextStyle: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.w700, fontSize: 18),
            dayPeriodTextColor: softColor,
            backgroundColor: primaryColor,
            hourMinuteColor: secondaryColor,
            hourMinuteTextColor: shadowColor,
            dialHandColor: primaryColor,
            dayPeriodColor: highlightColor,
            dialBackgroundColor: secondaryColor),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
            foregroundColor: highlightColor,
            iconSize: 35),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: secondaryColor,
          dayForegroundColor: const MaterialStatePropertyAll(primaryColor),
          headerForegroundColor: shadowColor,
          dividerColor: softColor,
          dayOverlayColor: const MaterialStatePropertyAll(highlightColor),
          todayForegroundColor: const MaterialStatePropertyAll(softColor),
          yearBackgroundColor: const MaterialStatePropertyAll(secondaryColor),
          yearForegroundColor: const MaterialStatePropertyAll(softColor),
          yearOverlayColor: const MaterialStatePropertyAll(primaryColor),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(softColor),
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(softColor),
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          todayBorder: const BorderSide(
            color: softColor,
            width: 2,
          ),
          yearStyle: GoogleFonts.robotoCondensed(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          dayStyle: GoogleFonts.robotoCondensed(
              color: primaryColor, fontWeight: FontWeight.w600),
          weekdayStyle: GoogleFonts.robotoCondensed(
            color: softColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}
