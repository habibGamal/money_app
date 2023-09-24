import 'package:flutter/material.dart';
import 'package:money_app/styles/fontStyle.dart';

class SizableText extends StatelessWidget {
  const SizableText(
    this.value, {
    this.fontSize = 18,
    this.canTranlate = true,
    super.key,
  });

  final String value;
  final bool canTranlate;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: fontStyle(
          context,
          canTranslate: canTranlate,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onBackground,
        ));
  }
}
