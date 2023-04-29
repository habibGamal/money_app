import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/styles/fontStyle.dart';

InputDecoration appInputDecoration(String lable, BuildContext context) {
  return InputDecoration(
    labelText: lable,
    labelStyle: fontStyle(
      context,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
