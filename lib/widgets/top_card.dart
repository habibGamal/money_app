import 'package:flutter/material.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/gray_text.dart';

class TopCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const TopCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
        // border: Border.all(color: color, width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GrayText(title),
            BoldText(value),
          ],
        ),
      ),
    );
  }
}
