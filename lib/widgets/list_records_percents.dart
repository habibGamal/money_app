import 'package:flutter/material.dart';
import 'package:money_app/models/record.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/record_percent.dart';

class ListRecordsPercents extends StatelessWidget {
  const ListRecordsPercents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GrayText('Expenses List'),
          SizedBox(height: 10),
          ...records.map((e) => RecordTilePercent(e)).toList()
          // RecordWidget()
        ],
      ),
    );
  }
}
