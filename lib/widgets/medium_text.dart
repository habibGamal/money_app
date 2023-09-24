import 'package:flutter/material.dart';
import 'package:money_app/styles/fontStyle.dart';

class MediumText extends StatelessWidget {
  const MediumText(
    this.value, {
    this.canTranlate = true,
    super.key,
  });

  final String value;
  final bool canTranlate;
  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: fontStyle(
          context,
          canTranslate: canTranlate,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onBackground,
        ));
  }
}
