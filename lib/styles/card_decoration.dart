import 'package:flutter/material.dart';

BoxDecoration cardDecoration(BuildContext context) {
  return BoxDecoration(
    // color: Theme.of(context).colorScheme.background,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
        spreadRadius: 1,
        blurRadius: 1,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
