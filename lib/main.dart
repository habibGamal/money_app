import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/pages/about.dart';
import 'package:money_app/pages/dedication.dart';
import 'package:money_app/pages/money_saving/add_saving_target.dart';
import 'package:money_app/pages/money_saving/edit_saving_target.dart';
import 'package:money_app/pages/money_saving/money_saving.dart';
import 'package:money_app/pages/money_saving/track_progress_of_saving.dart';
import 'package:money_app/pages/money_spend/add_record.dart';
import 'package:money_app/pages/money_spend/edit_record.dart';
import 'package:money_app/pages/money_spend/money_spend.dart';
import 'package:money_app/pages/plan_expenses/cta_display.dart';
import 'package:money_app/pages/plan_expenses/info_from.dart';
import 'package:money_app/pages/plan_expenses/preferences_form.dart';
import 'package:money_app/pages/plan_expenses/show_plan.dart';
import 'package:money_app/styles/dark_theme.dart';
import 'package:money_app/styles/light_theme.dart';
import 'package:provider/provider.dart';

Future<void> scheduleNotification() async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'مرحبا',
          body: 'لقد مضى وقت طويل منذ أن استخدمت التطبيق!',
          notificationLayout: NotificationLayout.BigPicture,
          category: NotificationCategory.Reminder,
          bigPicture: 'asset://assets/images/melted-clock.png'),
      schedule: NotificationInterval(
        preciseAlarm: true,
        interval: 60 * 60 * 24 * 3,
        timeZone: localTimeZone,
        allowWhileIdle: true,
      ));
}

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          importance: NotificationImportance.High,
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          playSound: true,
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    // debug: true,
  );
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
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
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
      scheduleNotification();
    });
    Provider.of<AppState>(context, listen: false).initPlanFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    testPlanClass();
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
        '/plan-expenses/cta': (context) => const CTADisplay(),
        '/plan-expenses/form': (context) => const InfoForm(),
        '/plan-expenses/preferences': (context) => const PreferencesForm(),
        '/plan-expenses/plan': (context) => const ShowPlan(),
        '/money-spend': (context) => const MoneySpendPage(),
        '/money-spend/add-record': (context) => const AddRecordPage(),
        '/money-spend/edit-record': (context) => const EditRecordPage(),
        '/money-saving': (context) => const MoneySaving(),
        '/money-saving/add-target': (context) => const AddSavingTarget(),
        '/money-saving/edit-target': (context) => const EditSavingTarget(),
        '/money-saving/track-progress-of-saving': (context) =>
            const TrackProgressOfSaving(),
        '/dedication': (context) => const Dedication(),
        '/about': (context) => const About(),
      },
      themeMode: Provider.of<AppState>(context).themeMode,
      darkTheme: darkTheme(context),
      theme: lightTheme(context),
      home: const CTADisplay(),
    );
  }
}
