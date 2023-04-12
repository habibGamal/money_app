import 'package:flutter/material.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/capitalize.dart';
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
    final mode = capitalize(appState.currentModeString);
    return records.recordsByCategories.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GrayText('${mode}s list'),
                SizedBox(height: 10),
                ...records.recordsByCategories
                    .map((e) => RecordTilePercent(e))
                    .toList()
              ],
            ),
          )
        : Empty();
  }
}
