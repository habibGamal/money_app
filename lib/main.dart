import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_app/notifiers/theme.dart';
import 'package:money_app/pages/add_record.dart';
import 'package:money_app/pages/money_spend.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/models/record.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/record.dart';
import 'package:money_app/widgets/top_cards.dart';
import './widgets/top_card.dart';
import './pages/money_spend.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('ru'),
        Locale('ja'),
        Locale('ar'),
        Locale('fa'),
        Locale('es'),
        Locale('it'),
      ],
      routes: {
        '/money-spend': (context) => const MoneySpendPage(),
        '/money-spend/add-record': (context) => const AddRecordPage(),
      },
      themeMode: themeManager.themeMode,
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: GoogleFonts.manrope().fontFamily,
            bodyColor: Colors.white),
        // inputDecorationTheme:InputDecorationTheme()
        scaffoldBackgroundColor: AppColors.primary,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.dark_2,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.dark_1,
            backgroundColor: AppColors.yellow,
          ),
        ),
        colorScheme: const ColorScheme.light(
          brightness: Brightness.dark,
          primary: AppColors.dark_1,
          onPrimary: AppColors.white_1,
          secondary: AppColors.yellow,
          onSecondary: Colors.white,
          surface: AppColors.primary,
          onSurface: AppColors.white_1,
          error: Colors.red,
          onError: Colors.red,
          background: AppColors.dark_1,
          onBackground: Colors.white,
          onTertiary: AppColors.textSecondaryDark,
        ),
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white_1,
          foregroundColor: AppColors.primary,
          elevation: 0,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.manrope().fontFamily,
            ),
        scaffoldBackgroundColor: AppColors.white_1,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.dark_1,
            backgroundColor: AppColors.yellow,
          ),
        ),
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.white_1,
          secondary: AppColors.yellow,
          onSecondary: AppColors.lightYellow,
          onSurface: Color.fromARGB(255, 63, 60, 60),
          surface: Color.fromARGB(255, 34, 33, 27),
          error: Colors.red,
          onError: Colors.red,
          background: Colors.white,
          onBackground: AppColors.primary,
          onTertiary: AppColors.textSecondaryLight,
        ),
      ),
      home: const MoneySpendPage(),
    );
  }
}
