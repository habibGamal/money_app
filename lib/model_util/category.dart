import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:provider/provider.dart';

class Category {
  final String title;
  final String titleAr;
  final FaIcon icon;
  final String colorName;
  final int id;
  const Category({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.icon,
    required this.colorName,
  });
  Color getColor(BuildContext context) {
    final themeMode =
        Provider.of<AppState>(context).isDarkMode ? 'dark' : 'light';
    final color = AppColors.colors[themeMode]?[colorName];
    if (color != null) {
      return color;
    }
    return Colors.white;
  }
}

const incomeCategories = [
  Category(
      id: 1,
      title: 'Salary',
      titleAr: 'الراتب',
      icon: FaIcon(
        Iconsax.dollar_circle,
        color: Colors.black38,
      ),
      colorName: 'yellow'),
  Category(
      id: 2,
      title: 'Bonus',
      titleAr: 'البونص',
      icon: FaIcon(
        Iconsax.wallet_add,
        color: Colors.black38,
      ),
      colorName: 'lightYellow'),
  Category(
      id: 3,
      title: 'Part time',
      titleAr: 'عمل جزئي',
      icon: FaIcon(
        Iconsax.empty_wallet_time,
        color: Colors.black38,
      ),
      colorName: 'lightYellow_2'),
  Category(
      id: 4,
      title: 'Freelance',
      titleAr: 'عمل حر',
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
    titleAr: 'الطعام',
    icon: FaIcon(
      FontAwesomeIcons.utensils,
      color: Colors.black38,
    ),
    colorName: 'lightGreen',
  ),
  Category(
    id: 2,
    title: 'Transport',
    titleAr: 'النقل',
    icon: FaIcon(
      FontAwesomeIcons.bus,
      color: Colors.black38,
    ),
    colorName: 'pink',
  ),
  Category(
    id: 3,
    title: 'Shopping',
    titleAr: 'التسوق',
    icon: FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.black38,
    ),
    colorName: 'yellow',
  ),
  Category(
    id: 4,
    title: 'Entertainment',
    titleAr: 'الترفيه',
    icon: FaIcon(
      FontAwesomeIcons.gamepad,
      color: Colors.black38,
    ),
    colorName: 'lightOrange',
  ),
  Category(
    id: 5,
    title: 'Car',
    titleAr: 'السيارة',
    icon: FaIcon(
      FontAwesomeIcons.car,
      color: Colors.black38,
    ),
    colorName: 'orange',
  ),
  Category(
    id: 6,
    title: 'Health',
    titleAr: 'الصحة',
    icon: FaIcon(
      FontAwesomeIcons.heartCircleCheck,
      color: Colors.black38,
    ),
    colorName: 'lightViolet',
  ),
  Category(
    id: 7,
    title: 'Phone',
    titleAr: 'الهاتف',
    icon: FaIcon(
      FontAwesomeIcons.phone,
      color: Colors.black38,
    ),
    colorName: 'violet',
  ),
  Category(
    id: 8,
    title: 'Clothes',
    titleAr: 'الملابس',
    icon: FaIcon(
      FontAwesomeIcons.shirt,
      color: Colors.black38,
    ),
    colorName: 'green',
  ),
  Category(
    id: 9,
    title: 'Gifts',
    titleAr: 'الهدايا',
    icon: FaIcon(
      FontAwesomeIcons.gifts,
      color: Colors.black38,
    ),
    colorName: 'sky',
  ),
  Category(
    id: 10,
    title: 'Others',
    titleAr: 'أخرى',
    icon: FaIcon(
      FontAwesomeIcons.ellipsis,
      color: Colors.black38,
    ),
    colorName: 'yellow',
  ),
];
