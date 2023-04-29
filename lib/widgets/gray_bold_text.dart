import 'package:flutter/material.dart';
import 'package:money_app/styles/fontStyle.dart';

class GrayBoldText extends StatelessWidget {
  const GrayBoldText(this.title, {this.canTranslate = true, super.key});

  final String title;
  final bool canTranslate;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: fontStyle(
        context,
        canTranslate: canTranslate,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onTertiary,
      ),
    );
  }
}
