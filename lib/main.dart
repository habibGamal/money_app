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
import 'package:money_app/pages/plan_expenses/plan_expenses.dart';
import 'package:money_app/styles/dark_theme.dart';
import 'package:money_app/styles/light_theme.dart';
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
        '/plan-expenses': (context) => const PlanExpenses(),
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
      darkTheme: darkTheme(context),
      theme: lightTheme(context),
      home: const MoneySpendPage(),
    );
  }
}
