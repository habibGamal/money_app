import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/gray_text.dart';

class TopCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final String cardId;
  final bool isSelected;
  final bool selectable;
  final Function callback;
  const TopCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.isSelected,
    required this.cardId,
    required this.callback,
    this.selectable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {callback()},
      child: Container(
        width: 110,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.onSecondary, width: 2)
                : null,
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                )
            ]),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GrayText(title),
              // BoldText(value),
              Text(value,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
