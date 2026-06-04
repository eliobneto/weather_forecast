import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  static AppTheme get instance => _instance;

  final theme = ThemeData(
    scaffoldBackgroundColor: Palette.secondary,
    primaryColor: Palette.white,
    hintColor: Palette.lightGrey,
    textTheme: _textTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    filledButtonTheme: const FilledButtonThemeData(),
    inputDecorationTheme: inputDecoration,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Palette.transparent,
    ),
    textSelectionTheme: const TextSelectionThemeData().copyWith(
      cursorColor: Palette.primary,
      selectionColor: Palette.primary.withAlpha(64),
      selectionHandleColor: Palette.primary,
    ),
    colorScheme: const ColorScheme.light().copyWith(surface: Palette.secondary),
  )..textTheme.apply(bodyColor: Palette.white, displayColor: Palette.white);

  static final _textTheme = TextTheme(
    titleLarge: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeTitle,
      fontWeight: FontWeight.bold,
      color: Palette.lightBlack,
    ),
    headlineLarge: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeSubtitle,
      fontWeight: FontWeight.bold,
      color: Palette.lightBlack,
    ),
    headlineMedium: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeLarger,
      fontWeight: FontWeight.normal,
      color: Palette.lightBlack,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeLarge,
      fontWeight: FontWeight.normal,
      color: Palette.lightBlack,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeNormal,
      fontWeight: FontWeight.normal,
      color: Palette.lightBlack,
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeSmall,
      fontWeight: FontWeight.normal,
      color: Palette.lightBlack,
    ),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Palette.secondary,
      backgroundColor: Palette.primary,
      elevation: 0.0,
      disabledForegroundColor: Palette.primary.withAlpha(128),
      disabledBackgroundColor: Palette.primary.withAlpha(64),
      padding: const EdgeInsets.symmetric(vertical: Constraints.paddingNormal),
      textStyle: GoogleFonts.openSans(
        fontSize: Constraints.fontSizeNormal,
        fontWeight: FontWeight.bold,
        color: Palette.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constraints.borderRadiusLarge),
      ),
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.maximumDensity,
      ),
    ),
  );

  static final inputDecoration = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: Constraints.paddingSmaller,
      horizontal: Constraints.paddingNormal,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Palette.darkGrey),
      borderRadius: BorderRadius.circular(Constraints.borderRadiusSmall),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Palette.darkGrey),
      borderRadius: BorderRadius.circular(Constraints.borderRadiusSmall),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.0, color: Palette.lightBlack),
      borderRadius: BorderRadius.circular(Constraints.borderRadiusSmall),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.0, color: Palette.red),
      borderRadius: BorderRadius.circular(Constraints.borderRadiusSmall),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.0, color: Palette.red),
      borderRadius: BorderRadius.circular(Constraints.borderRadiusSmall),
    ),
    errorStyle: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeSmaller,
      color: Palette.red,
    ),
    errorMaxLines: 2,
    hintStyle: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeNormal,
      color: Palette.darkGrey,
    ),
    floatingLabelStyle: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeNormal,
      color: Palette.lightBlack,
    ),
    labelStyle: GoogleFonts.openSans(
      fontSize: Constraints.fontSizeNormal,
      color: Palette.darkGrey,
    ),
    fillColor: Palette.white,
    filled: true,
  );
}
