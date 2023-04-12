import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/notifiers/app_state.dart';
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
    return Consumer<AppState>(
      builder: (context, appState, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopCard(
            title: 'Income',
            value: '\$ ${appState.totalIncome}',
            color: Color.fromARGB(255, 40, 170, 51),
            isSelected: appState.currentMode == Mode.income,
            cardId: 'Income',
            callback: () => modeToIncome(),
          ),
          TopCard(
            title: 'Expense',
            value: '\$ ${appState.totalExpense}',
            color: Color.fromARGB(255, 216, 61, 66),
            isSelected: appState.currentMode == Mode.expense,
            cardId: 'Expense',
            callback: () => modeToExpence(),
          ),
          TopCard(
            title: 'Balance',
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
