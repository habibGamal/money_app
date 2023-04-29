import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/list_records_percents.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ChartRecords extends StatelessWidget {
  const ChartRecords({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final Map<String, double> dataMap = {};
    final records = appState.records.recordsByCategories;
    final t = translate(context);
    for (var record in records) {
      dataMap[t(record.category.title, record.category.titleAr)] =
          record.percentage;
    }
    final colors =
        records.map((record) => record.category.getColor(context)).toList();
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
            baseChartColor: Colors.grey[300]!,
            centerTextStyle: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            legendOptions: LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
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
