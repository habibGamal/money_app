import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/pages/money_saving/add_saving_target.dart';
import 'package:money_app/pages/money_saving/edit_saving_target.dart';
import 'package:money_app/pages/money_saving/money_saving.dart';
import 'package:money_app/pages/money_saving/track_progress_of_saving.dart';
import 'package:money_app/pages/money_spend/add_record.dart';
import 'package:money_app/pages/money_spend/edit_record.dart';
import 'package:money_app/pages/money_spend/money_spend.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppState()),
      ChangeNotifierProvider(create: (context) => MoneySavingState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<AppState>(context, listen: false).initLangFromDB();
    super.initState();
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
      locale: Locale(Provider.of<AppState>(context).language),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      routes: {
        '/money-spend': (context) => const MoneySpendPage(),
        '/money-spend/add-record': (context) => const AddRecordPage(),
        '/money-spend/edit-record': (context) => const EditRecordPage(),
        '/money-saving': (context) => const MoneySaving(),
        '/money-saving/add-target': (context) => const AddSavingTarget(),
        '/money-saving/edit-target': (context) => const EditSavingTarget(),
        '/money-saving/track-progress-of-saving': (context) =>
            const TrackProgressOfSaving(),
      },
      themeMode: Provider.of<AppState>(context).themeMode,
      darkTheme: ThemeData(
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
            foregroundColor: AppColors.dark_1,
            backgroundColor: AppColors.yellow,
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
      ),
      home: const MoneySpendPage(),
    );
  }
}
