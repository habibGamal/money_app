import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_app/main.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/capitalize.dart';
import 'package:money_app/widgets/empty.dart';
import 'package:money_app/widgets/list_records_of_day.dart';
import 'package:money_app/widgets/list_records_percents.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/top_cards.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';

class MoneySpendPage extends StatefulWidget {
  const MoneySpendPage({super.key});

  @override
  State<MoneySpendPage> createState() => _MoneySpendPageState();
}

final List _pages = [
  const ListRecords(),
  ChartRecords(),
];

class _MoneySpendPageState extends State<MoneySpendPage> {
  int _currentPage = 0;
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  updateRecords() {
    Provider.of<AppState>(context, listen: false).refreshRecords();
  }

  initRecords() {
    final appState = Provider.of<AppState>(context, listen: false);
    dateFrom.text = DateFormat('dd MMM').format(appState.dateFrom);
    dateTo.text = DateFormat('dd MMM').format(appState.dateTo);
    updateRecords();
  }

  updateDateFrom(DateTime date) {
    Provider.of<AppState>(context, listen: false).updateDateFrom(date);
    updateRecords();
    dateFrom.text = DateFormat('dd MMM').format(date);
  }

  updateDateTo(DateTime date) {
    Provider.of<AppState>(context, listen: false).updateDateTo(date);
    updateRecords();
    dateTo.text = DateFormat('dd MMM').format(date);
  }

  @override
  void initState() {
    initRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Row(children: const [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber,
                  ),
                  SizedBox(width: 10),
                  NormalText("MONEY APP"),
                ]),
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.moneyCheck),
              title: const NormalText('Money Saving'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.circleHalfStroke),
              title: const NormalText('Change Mode'),
              onTap: () {
                themeManager.setThemeMode(
                    themeManager.themeMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light);
              },
            ),
          ],
        ),
      ),
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

class ChartRecords extends StatelessWidget {
  const ChartRecords({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final mode = capitalize(appState.currentModeString);
    final Map<String, double> dataMap = {};
    final records = appState.records.recordsByCategories;
    for (var record in records) {
      dataMap[record.category.title] = record.percentage;
    }
    final colors = records.map((record) => record.category.color).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [
        if (dataMap.isNotEmpty)
          PieChart(
            dataMap: dataMap,
            colorList: colors,
            chartType: ChartType.ring,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            ringStrokeWidth: 16,
            chartLegendSpacing: 90,
            baseChartColor: Colors.grey[300]!,
            centerTextStyle: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValues: false,
            ),
          ),
        const SizedBox(height: 20),
        const ListRecordsPercents(),
      ]),
    );
  }
}

class ListRecords extends StatelessWidget {
  const ListRecords({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [
        const TopCards(),
        const SizedBox(height: 20),
        Consumer<AppState>(
          builder: (context, appState, child) {
            return Column(
              children: appState.records.recordsByDays.isNotEmpty
                  ? appState.records.recordsByDays
                      .map((recordsOfDay) => ListRecordsOfDay(recordsOfDay))
                      .toList()
                  : const [Empty()],
            );
          },
        )
      ]),
    );
  }
}
