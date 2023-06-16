import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/app_colors.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.light_4,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: GoogleFonts.manrope().fontFamily,
          ),
      scaffoldBackgroundColor: AppColors.light_4,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: AppColors.light_1,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.light_4,
      ),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.light_1,
        onPrimary: AppColors.light_4,
        secondary: AppColors.yellow,
        onSecondary: AppColors.light_3,
        surface: AppColors.light_1,
        onSurface: AppColors.light_2,
        background: AppColors.light_5,
        onBackground: AppColors.light_1,
        onTertiary: AppColors.textSecondaryLight,
        error: Colors.red,
        onError: Colors.red,
      ),
    );
