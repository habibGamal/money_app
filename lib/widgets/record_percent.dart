import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/gray_bold_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RecordTilePercent extends StatelessWidget {
  final RecordsByCategory record;
  const RecordTilePercent(
    this.record, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: record.category.color,
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: record.category.icon),
      ),
      title: GrayBoldText(record.category.title),
      subtitle: LinearPercentIndicator(
        padding: EdgeInsets.zero,
        lineHeight: 6,
        percent: record.percentage / 100,
        animation: true,
        barRadius: const Radius.circular(16),
        backgroundColor: Colors.grey[200],
        progressColor: record.category.color,
      ),
      trailing: SizedBox(
        width: 50,
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText('\$ ${record.totalAmount.toString()}'),
              GrayBoldText('${record.percentage.toStringAsFixed(1)}%'),
            ],
          ),
        ),
      ),
      onTap: () => {},
    );
  }
}
