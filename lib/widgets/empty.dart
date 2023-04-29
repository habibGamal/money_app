import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:provider/provider.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
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
            Provider.of<AppState>(context).isLightMode
                ? Image.asset('assets/audit.png', width: 100, height: 100)
                : Image.asset('assets/dark.png', width: 100, height: 100),
            const SizedBox(height: 16),
            Text(t('No Data', 'لا يوجد بيانات'),
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  // color: Color(0xFFe6e5ed),
                  color: Theme.of(context).colorScheme.onTertiary,
                )),
          ],
        ));
  }
}
