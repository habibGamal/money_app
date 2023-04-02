import 'package:flutter/material.dart';

class KeyboardDismiss extends StatelessWidget {
  final Widget child;
  const KeyboardDismiss({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
