import 'package:employee_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(double textScaleFactor) {
    return ThemeData(
      primaryColor: const Color(0xFFFB4E2C),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
      ),
      colorScheme: const ColorScheme(
        primary: AppColors.primaryColor,
        primaryContainer: AppColors.primaryContainerColor,
        secondary: AppColors.accentColor,
        secondaryContainer: AppColors.secondaryContainerColor,
        surface: AppColors.surfaceColor,
        background: AppColors.backgroundColor,
        error: AppColors.errorColor,
        onPrimary: AppColors.onPrimaryColor,
        onSecondary: AppColors.onSecondaryColor,
        onSurface: AppColors.onSurfaceColor,
        onBackground: AppColors.onBackgroundColor,
        onError: AppColors.onErrorColor,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        toolbarTextStyle: TextTheme(
          titleLarge: GoogleFonts.sen(
            color: AppColors.blackColor,
            fontSize: 20.sp / textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).bodyMedium,
        titleTextStyle: TextTheme(
          titleLarge: GoogleFonts.sen(
            color: AppColors.blackColor,
            fontSize: 20.sp / textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).titleLarge,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sen(
          fontSize: 96.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
          color: AppColors.primaryTextColor,
        ),
        displayMedium: GoogleFonts.sen(
          fontSize: 60.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          color: AppColors.primaryTextColor,
        ),
        displaySmall: GoogleFonts.sen(
          fontSize: 48.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTextColor,
        ),
        headlineMedium: GoogleFonts.sen(
          fontSize: 34.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.25,
          color: AppColors.primaryTextColor,
        ),
        headlineSmall: GoogleFonts.sen(
          fontSize: 24.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.25,
          color: AppColors.primaryTextColor,
        ),
        titleLarge: GoogleFonts.sen(
          fontSize: 20.sp / textScaleFactor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.15,
          color: AppColors.primaryTextColor,
        ),
        titleMedium: GoogleFonts.sen(
          fontSize: 16.sp / textScaleFactor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
          color: AppColors.primaryTextColor,
        ),
        titleSmall: GoogleFonts.sen(
          fontSize: 14.sp / textScaleFactor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
          color: AppColors.primaryTextColor,
        ),
        bodyLarge: GoogleFonts.sen(
          fontSize: 16.sp / textScaleFactor,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.15,
          color: AppColors.primaryTextColor,
        ),
        bodyMedium: GoogleFonts.sen(
          fontSize: 14.sp / textScaleFactor,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.15,
          color: AppColors.secondaryTextColor,
        ),
        bodySmall: GoogleFonts.sen(
          fontSize: 12.sp / textScaleFactor,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.15,
          color: AppColors.secondaryTextColor,
        ),
        labelLarge: GoogleFonts.sen(
            fontSize: 14.sp / textScaleFactor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.25,
            color: AppColors.secondaryTextColor),
        labelSmall: GoogleFonts.sen(
          fontSize: 10.sp / textScaleFactor,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.5,
          color: AppColors.secondaryTextColor,
        ),
      ),
    );
  }
}
