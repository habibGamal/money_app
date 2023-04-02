import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/widgets/gray_text.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: category.color,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Center(child: category.icon),
        ),
        const SizedBox(height: 10),
        Text(category.title,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onBackground,
            ))
      ],
    );
  }
}
