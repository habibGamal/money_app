import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/top_card.dart';

class TopCards extends StatelessWidget {
  const TopCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        TopCard(
          title: 'Income',
          value: '\$ 1,000',
          color: AppColors.lightGreen,
        ),
        TopCard(
          title: 'Expense',
          value: '\$ 500',
          color: AppColors.pink,
        ),
        TopCard(
          title: 'Balance',
          value: '\$ 1,500',
          color: Colors.black38,
        ),
      ],
    );
  }
}
