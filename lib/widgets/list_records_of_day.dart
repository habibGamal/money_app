import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/LTR_only.dart';
import 'package:money_app/widgets/app_card.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/record.dart';

class ListRecordsOfDay extends StatelessWidget {
  final RecordsByDay recordsByDay;
  const ListRecordsOfDay(
    this.recordsByDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrayText(
                    t(recordsByDay.dayEn, recordsByDay.dayAr),
                  ),
                  LTROnly(
                    child: GrayText(
                      '\$ ${recordsByDay.totalAmount}',
                      canTranslate: false,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ...recordsByDay.records
                  .map((record) => RecordTile(record))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
