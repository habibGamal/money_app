import 'package:flutter/material.dart';
import 'package:money_app/styles/fontStyle.dart';

class GrayText extends StatelessWidget {
  const GrayText(this.title, {this.canTranslate = true, super.key});

  final String title;
  final bool canTranslate;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: fontStyle(
          context,
          canTranslate: canTranslate,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onTertiary,
        ));
  }
}
