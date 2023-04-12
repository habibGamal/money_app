import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/notifiers/theme.dart';
import 'package:money_app/pages/add_record.dart';
import 'package:money_app/pages/edit_record.dart';
import 'package:money_app/pages/money_spend.dart';
import 'package:money_app/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: const MyApp(),
  ));
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
        '/money-spend/edit-record': (context) => EditRecordPage(context),
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
        dialogBackgroundColor: AppColors.dark_2,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.dark_2,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: AppColors.dark_2,
        ),
        scaffoldBackgroundColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          // brightness: Brightness.dark,
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
      ),
      theme: ThemeData(
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
      ),
      home: const MoneySpendPage(),
    );
  }
}
