import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/app_colors.dart';

ThemeData darkTheme(BuildContext context) => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: Theme.of(context).textTheme.apply(
          fontFamily: GoogleFonts.manrope().fontFamily,
          bodyColor: Colors.white),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.dark_2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.colors['dark']?['yellow'],
        ),
      ),
      dialogBackgroundColor: AppColors.dark_2,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.dark_2,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.dark_2,
      ),
      scaffoldBackgroundColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.dark_3,
        onPrimary: AppColors.dark_5,
        secondary: AppColors.yellow,
        onSecondary: AppColors.dark_3,
        surface: AppColors.dark_1,
        onSurface: AppColors.light_3,
        background: AppColors.dark_2,
        onBackground: AppColors.dark_5,
        onTertiary: AppColors.dark_4,
        error: Colors.red,
        onError: Colors.red,
      ),
    );
