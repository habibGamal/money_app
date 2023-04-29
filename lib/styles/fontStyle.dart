import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/tools/translate.dart';

fontStyle(
  BuildContext context, {
  bool canTranslate = true,
  double fontSize = 14,
  fontWeight = FontWeight.w500,
  color = Colors.black,
}) {
  final t = translate(context);

  final enFont = GoogleFonts.manrope(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  final arFont = GoogleFonts.tajawal(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  if (!canTranslate) return enFont;

  return t(enFont, arFont);
}
