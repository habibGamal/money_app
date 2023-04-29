import 'package:flutter/material.dart';
import 'package:money_app/styles/fontStyle.dart';

class SmallText extends StatelessWidget {
  const SmallText(
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
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onBackground,
        ));
  }
}
