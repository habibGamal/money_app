import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/widgets/gray_text.dart';
import '../model_util/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final int selectedCategory;
  final Function(int) callback;
  const CategoryCard(
    this.category, {
    super.key,
    required this.selectedCategory,
    required this.callback,
  });
  get isSelected => category.id == selectedCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(category.id),
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.yellow : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
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
              FittedBox(
                child: Text(category.title,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
              )
            ],
          ),
        ),
        if (isSelected)
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(57, 230, 229, 229),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.yellow,
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
