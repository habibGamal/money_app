import 'package:flutter/material.dart';
import 'package:money_app/models/record.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/record.dart';

class ListRecordsOfDay extends StatelessWidget {
  const ListRecordsOfDay({
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [GrayText('Yesterday'), GrayText('\$ 85.70')],
          ),
          ...records.map((e) => RecordTile(e)).toList()
          // RecordWidget()
        ],
      ),
    );
  }
}
