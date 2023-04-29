import 'package:flutter/material.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/widgets/empty.dart';
import 'package:money_app/widgets/list_records_of_day.dart';
import 'package:money_app/widgets/top_cards.dart';
import 'package:provider/provider.dart';

class ListRecords extends StatelessWidget {
  const ListRecords({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [
        const TopCards(),
        const SizedBox(height: 20),
        Consumer<AppState>(
          builder: (context, appState, child) {
            return Column(
              children: appState.records.recordsByDays.isNotEmpty
                  ? appState.records.recordsByDays
                      .map((recordsOfDay) => ListRecordsOfDay(recordsOfDay))
                      .toList()
                  : const [Empty()],
            );
          },
        )
      ]),
    );
  }
}
