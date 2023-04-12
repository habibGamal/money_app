import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:money_app/main.dart';

class Category {
  final String title;
  final FaIcon icon;
  final String colorName;
  final int id;
  const Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.colorName,
  });
  Color get color {
    final themeMode =
        themeManager.themeMode == ThemeMode.dark ? 'dark' : 'light';
    final color = AppColors.colors[themeMode]?[colorName];
    if (color != null) {
      return color;
    }
    return Colors.red;
  }
}

const incomeCategories = [
  Category(
      id: 1,
      title: 'Salary',
      icon: FaIcon(
        Iconsax.dollar_circle,
        color: Colors.black38,
      ),
      colorName: 'yellow'),
  Category(
      id: 2,
      title: 'Bonus',
      icon: FaIcon(
        Iconsax.wallet_add,
        color: Colors.black38,
      ),
      colorName: 'lightYellow'),
  Category(
      id: 3,
      title: 'Part time',
      icon: FaIcon(
        Iconsax.empty_wallet_time,
        color: Colors.black38,
      ),
      colorName: 'lightYellow_2'),
  Category(
      id: 4,
      title: 'Freelance',
      icon: FaIcon(
        Iconsax.card,
        color: Colors.black38,
      ),
      colorName: 'lightYellow_3'),
];

const expenseCategories = [
  Category(
    id: 1,
    title: 'Food',
    icon: FaIcon(
      FontAwesomeIcons.utensils,
      color: Colors.black38,
    ),
    colorName: 'lightGreen',
  ),
  Category(
    id: 2,
    title: 'Transport',
    icon: FaIcon(
      FontAwesomeIcons.bus,
      color: Colors.black38,
    ),
    colorName: 'pink',
  ),
  Category(
    id: 3,
    title: 'Shopping',
    icon: FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.black38,
    ),
    colorName: 'yellow',
  ),
  Category(
    id: 4,
    title: 'Entertainment',
    icon: FaIcon(
      FontAwesomeIcons.gamepad,
      color: Colors.black38,
    ),
    colorName: 'lightOrange',
  ),
  Category(
    id: 5,
    title: 'Car',
    icon: FaIcon(
      FontAwesomeIcons.car,
      color: Colors.black38,
    ),
    colorName: 'orange',
  ),
  Category(
    id: 6,
    title: 'Health',
    icon: FaIcon(
      FontAwesomeIcons.heartCircleCheck,
      color: Colors.black38,
    ),
    colorName: 'lightViolet',
  ),
  Category(
    id: 7,
    title: 'Phone',
    icon: FaIcon(
      FontAwesomeIcons.phone,
      color: Colors.black38,
    ),
    colorName: 'violet',
  ),
  Category(
    id: 8,
    title: 'Clothes',
    icon: FaIcon(
      FontAwesomeIcons.shirt,
      color: Colors.black38,
    ),
    colorName: 'green',
  ),
  Category(
    id: 9,
    title: 'Gifts',
    icon: FaIcon(
      FontAwesomeIcons.gifts,
      color: Colors.black38,
    ),
    colorName: 'sky',
  ),
  Category(
    id: 10,
    title: 'Others',
    icon: FaIcon(
      FontAwesomeIcons.ellipsis,
      color: Colors.black38,
    ),
    colorName: 'yellow',
  ),
];
