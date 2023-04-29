import 'package:flutter/material.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_card.dart';
import 'package:money_app/widgets/empty.dart';
// import 'package:money_app/model_util/record.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/record_percent.dart';
import 'package:provider/provider.dart';

class ListRecordsPercents extends StatelessWidget {
  const ListRecordsPercents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final records = appState.records;
    final t = translate(context);
    return records.recordsByCategories.isNotEmpty
        ? AppCard(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GrayText(appState.currentMode == Mode.expense
                      ? t('Expenses list', 'قائمة المصروفات')
                      : t('Income list', 'قائمة الدخل')),
                  const SizedBox(height: 10),
                  ...records.recordsByCategories
                      .map((e) => RecordTilePercent(e))
                      .toList()
                ],
              ),
            ),
          )
        : const Empty();
  }
}
