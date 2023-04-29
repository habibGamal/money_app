import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/pages/money_spend/chart_records.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'list_records.dart';

class MoneySpendPage extends StatefulWidget {
  const MoneySpendPage({super.key});

  @override
  State<MoneySpendPage> createState() => _MoneySpendPageState();
}

const List<Widget> _pages = [
  ListRecords(),
  ChartRecords(),
];

class _MoneySpendPageState extends State<MoneySpendPage> {
  int _currentPage = 0;
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  updateRecords() {
    Provider.of<AppState>(context, listen: false).refreshRecords();
  }

  String format(DateTime date, {locale = 'en'}) {
    // final locale = Provider.of<AppState>(context, listen: false).language;
    return DateFormat('dd MMM', locale).format(date);
  }

  initRecords() {
    final appState = Provider.of<AppState>(context, listen: false);
    dateFrom.text = format(appState.dateFrom);
    dateTo.text = format(appState.dateTo);
    updateRecords();
  }

  updateDateFrom(DateTime date) {
    Provider.of<AppState>(context, listen: false).updateDateFrom(date);
    updateRecords();
    dateFrom.text = format(date);
  }

  updateDateTo(DateTime date) {
    Provider.of<AppState>(context, listen: false).updateDateTo(date);
    updateRecords();
    dateTo.text = format(date);
  }

  @override
  void initState() {
    initRecords();
    super.initState();
  }

  changeDateLocale(String locale) {
    final appState = Provider.of<AppState>(context, listen: false);
    dateFrom.text = format(appState.dateFrom, locale: locale);
    dateTo.text = format(appState.dateTo, locale: locale);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<AppState>(context).language;
    changeDateLocale(locale);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 75,
              child: TextField(
                controller: dateFrom,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 30),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (pickedDate != null) updateDateFrom(pickedDate);
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Expanded(
                child: Icon(
              Icons.arrow_forward,
            )),
            Expanded(
              child: TextField(
                controller: dateTo,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) updateDateTo(pickedDate);
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
      body: _pages.elementAt(_currentPage),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/money-spend/add-record'),
        tooltip: 'Increment',
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _currentPage = 0;
                  });
                },
                icon: Icon(
                  Iconsax.calendar_tick,
                  color: _currentPage == 0 ? AppColors.yellow : null,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              icon: Icon(
                Iconsax.diagram,
                color: _currentPage == 1 ? AppColors.yellow : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
