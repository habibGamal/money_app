import 'package:flutter/material.dart';
import 'package:money_app/tools/translate.dart';

class AdjustLayoutDirection extends StatelessWidget {
  final Widget child;
  const AdjustLayoutDirection({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Directionality(
        textDirection: t(TextDirection.ltr, TextDirection.rtl), child: child);
  }
}
