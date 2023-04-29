import 'package:flutter/material.dart';
import 'package:money_app/styles/card_decoration.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  const AppCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.background,
        child: child,
      ),
    );
  }
}
