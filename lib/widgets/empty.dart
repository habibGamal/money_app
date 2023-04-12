import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/main.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            themeManager.themeMode == ThemeMode.light
                ? Image.asset('assets/audit.png', width: 100, height: 100)
                : Image.asset('assets/dark.png', width: 100, height: 100),
            const SizedBox(height: 16),
            Text('No Data',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // color: Color(0xFFe6e5ed),
                  color: Theme.of(context).colorScheme.onTertiary,
                )),
          ],
        ));
  }
}
