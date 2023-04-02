import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/main.dart';
import 'package:money_app/widgets/list_records_of_day.dart';
import 'package:money_app/widgets/list_records_percents.dart';
import 'package:money_app/widgets/record_percent.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/models/record.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/record.dart';
import 'package:money_app/widgets/top_cards.dart';
import 'package:iconsax/iconsax.dart';

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

  @override
  void initState() {
    dateFrom.text = "1 Mar";
    dateTo.text = "5 Mar";
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
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2101),
                  );
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Expanded(
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
                },
                decoration: InputDecoration(
                    fillColor: AppColors.white_1, border: InputBorder.none),
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
  ChartRecords({
    super.key,
  });

  final Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [
        PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          ringStrokeWidth: 16,
          chartLegendSpacing: 90,
          baseChartColor: Colors.grey[300]!,
          centerText: "Expenses",
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
          chartValuesOptions: ChartValuesOptions(
            showChartValues: false,
          ),
        ),
        const SizedBox(height: 20),
        ListRecordsPercents(),
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
        ListRecordsOfDay()
      ]),
    );
  }
}
