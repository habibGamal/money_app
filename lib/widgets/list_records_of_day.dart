import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/record.dart';
import 'package:provider/provider.dart';

class ListRecordsOfDay extends StatelessWidget {
  final RecordsByDay recordsByDay;
  const ListRecordsOfDay(
    this.recordsByDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GrayText(recordsByDay.day),
              GrayText('\$ ${recordsByDay.totalAmount}')
            ],
          ),
          ...recordsByDay.records.map((record) => RecordTile(record)).toList()
        ],
      ),
    );
  }
}
