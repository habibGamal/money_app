import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_app/model_util/record_type.dart';
import 'package:money_app/model_util/records_util.dart';
import '../model/model.dart';

enum Mode { expense, income }

class AppState extends ChangeNotifier {
  // records
  List<Record> _records = [];

  List<Record> get recordsDB => _records;

  RecordsUtil get records {
    return RecordsUtil(recordsDB);
  }

  // theme
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  bool get isLightMode => themeMode == ThemeMode.light;
  // language
  String _language = 'en';

  String get language => _language;

  bool get isAR => _language == 'ar';

  bool get isEN => _language == 'en';

  // plan
  String? _plan;

  String? get plan => _plan;

  // mode
  Mode _currentMode = Mode.expense;

  Mode get currentMode => _currentMode;

  String get currentModeString => _currentMode.toString().split('.').last;

  bool get currentRecordType =>
      _currentMode == Mode.expense ? RecordType.expense : RecordType.income;

  // date from
  DateTime _dateFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);

  DateTime get dateFrom => _dateFrom;

  // date to
  DateTime _dateTo = DateTime.now();

  DateTime get dateTo => _dateTo;

  void updateMode(Mode mode) {
    _currentMode = mode;
    notifyListeners();
  }

  void updateDateFrom(DateTime date) {
    _dateFrom = date;
    notifyListeners();
  }

  void updateDateTo(DateTime date) {
    _dateTo = date;
    notifyListeners();
  }

  double _totalIncome = 0;
  double _totalExpense = 0;
  get totalIncome => _totalIncome;
  get totalExpense => _totalExpense;
  get balance => totalIncome - totalExpense;

  _getTotalOf(bool type) async {
    return (await Record()
        .select(columnsToSelect: ['SUM(amount) as total'])
        .type
        .equals(type)
        .and
        .date
        .greaterThanOrEquals(dateFrom)
        .and
        .date
        .lessThanOrEquals(dateTo)
        .toListObject())[0]['total'];
  }

  refreshTotalIncomeAndExpense() async {
    _totalIncome = await _getTotalOf(RecordType.income) ?? 0;
    _totalExpense = await _getTotalOf(RecordType.expense) ?? 0;
  }

  refreshRecords() async {
    final records = await Record()
        .select()
        .type
        .equals(currentRecordType)
        .and
        .date
        .greaterThanOrEquals(dateFrom)
        .and
        .date
        .lessThanOrEquals(dateTo)
        .orderByDesc('date')
        .toList();
    _records = records;
    await refreshTotalIncomeAndExpense();
    notifyListeners();
  }

  void updateRecords(List<Record> records) {
    _records = records;
    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode =
        themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleLanguage() {
    _language = _language == 'ar' ? 'en' : 'ar';
    updateLangInDB();
    initializeDateFormatting('ar_SA');
    notifyListeners();
  }

  updateLangInDB() async {
    final lang = await Preference().select().name.equals('lang').toSingle();
    if (lang != null) {
      lang.value = _language;
      lang.save();
    }
  }

  Future<void> initLangFromDB() async {
    final lang = await Preference().select().name.equals('lang').toSingle();
    if (lang != null) _language = lang.value!;
    if (lang == null) {
      await Preference.withFields('lang', 'en').save();
    }
    notifyListeners();
  }

  updatePlanInDB(Map<String, double> planMap) async {
    final plan = await Preference().select().name.equals('plan').toSingle();
    if (plan != null) {
      plan.value = jsonEncode(planMap);
      plan.save();
    }
  }

  void initPlanFromDB() async {
    final plan = await Preference().select().name.equals('plan').toSingle();
    if (plan != null) _plan = plan.value;
    if (plan == null) {
      await Preference.withFields('plan', jsonEncode({})).save();
    }
    notifyListeners();
  }
}
