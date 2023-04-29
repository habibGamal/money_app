import 'package:flutter/material.dart';

class LTROnly extends StatelessWidget {
  final Widget child;
  const LTROnly({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
