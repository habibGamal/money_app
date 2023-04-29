import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/LTR_only.dart';
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
    final t = translate(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: record.category.getColor(context),
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: record.category.icon),
      ),
      title: GrayBoldText(t(record.category.title, record.category.titleAr)),
      subtitle: LinearPercentIndicator(
        isRTL: t(false, true),
        padding: EdgeInsets.zero,
        lineHeight: 6,
        percent: record.percentage / 100,
        animation: true,
        barRadius: const Radius.circular(16),
        backgroundColor: Colors.grey[200],
        progressColor: record.category.getColor(context),
      ),
      trailing: SizedBox(
        width: 50,
        child: FittedBox(
          child: LTROnly(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(
                  '\$ ${record.totalAmount.toString()}',
                  canTranlate: false,
                ),
                GrayBoldText(
                  '${record.percentage.toStringAsFixed(1)}%',
                  canTranslate: false,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => {},
    );
  }
}
