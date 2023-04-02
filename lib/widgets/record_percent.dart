import 'package:flutter/material.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/gray_bold_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/gray_text.dart';
import '../models/record.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RecordTilePercent extends StatelessWidget {
  final Record item;
  const RecordTilePercent(
    this.item, {
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
          color: item.category.color,
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: item.category.icon),
      ),
      title: GrayBoldText(item.category.title),
      subtitle: LinearPercentIndicator(
        padding: EdgeInsets.zero,
        lineHeight: 6,
        percent: 0.5,
        animation: true,
        barRadius: const Radius.circular(16),
        backgroundColor: Colors.grey[200],
        progressColor: item.category.color,
      ),
      trailing: BoldText(item.value),
      onTap: () => {},
    );
  }
}
