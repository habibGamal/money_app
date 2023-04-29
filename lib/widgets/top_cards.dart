import 'package:flutter/material.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/top_card.dart';
import 'package:provider/provider.dart';

class TopCards extends StatefulWidget {
  const TopCards({
    super.key,
  });

  @override
  State<TopCards> createState() => _TopCardsState();
}

class _TopCardsState extends State<TopCards> {
  updateRecords() {
    Provider.of<AppState>(context, listen: false).refreshRecords();
  }

  modeToIncome() {
    Provider.of<AppState>(context, listen: false).updateMode(Mode.income);
    updateRecords();
  }

  modeToExpence() {
    Provider.of<AppState>(context, listen: false).updateMode(Mode.expense);
    updateRecords();
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Consumer<AppState>(
      builder: (context, appState, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopCard(
            title: t('Income', 'الدخل'),
            value: '\$ ${appState.totalIncome}',
            color: const Color.fromARGB(255, 40, 170, 51),
            isSelected: appState.currentMode == Mode.income,
            cardId: 'Income',
            callback: () => modeToIncome(),
          ),
          TopCard(
            title: t('Expense', 'المصروفات'),
            value: '\$ ${appState.totalExpense}',
            color: const Color.fromARGB(255, 216, 61, 66),
            isSelected: appState.currentMode == Mode.expense,
            cardId: 'Expense',
            callback: () => modeToExpence(),
          ),
          TopCard(
            title: t('Balance', 'الرصيد'),
            value: appState.balance >= 0
                ? '\$ ${appState.balance}'
                : '-\$ ${appState.balance.abs()}',
            color: Theme.of(context).colorScheme.onBackground.withAlpha(190),
            isSelected: false,
            cardId: 'Balance',
            callback: () => {},
            selectable: false,
          ),
        ],
      ),
    );
  }
}
