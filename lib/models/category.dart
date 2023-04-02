import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';

class Category {
  final String title;
  final FaIcon icon;
  final Color color;
  final int id;
  const Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}

const categories = [
  Category(
    id: 1,
    title: 'Food',
    icon: FaIcon(
      FontAwesomeIcons.utensils,
      color: Colors.black38,
    ),
    color: AppColors.lightGreen,
  ),
  Category(
    id: 2,
    title: 'Transport',
    icon: FaIcon(
      FontAwesomeIcons.bus,
      color: Colors.black38,
    ),
    color: AppColors.pink,
  ),
  Category(
    id: 3,
    title: 'Shopping',
    icon: FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.black38,
    ),
    color: AppColors.yellow,
  ),
  Category(
    id: 4,
    title: 'Entertainment',
    icon: FaIcon(
      FontAwesomeIcons.gamepad,
      color: Colors.black38,
    ),
    color: AppColors.lightOrange,
  ),
  Category(
    id: 5,
    title: 'Car',
    icon: FaIcon(
      FontAwesomeIcons.car,
      color: Colors.black38,
    ),
    color: AppColors.orange,
  ),
  Category(
    id: 6,
    title: 'Health',
    icon: FaIcon(
      FontAwesomeIcons.heartCircleCheck,
      color: Colors.black38,
    ),
    color: AppColors.lightViolet,
  ),
  Category(
    id: 7,
    title: 'Phone',
    icon: FaIcon(
      FontAwesomeIcons.phone,
      color: Colors.black38,
    ),
    color: AppColors.violet,
  ),
  Category(
    id: 7,
    title: 'Clothes',
    icon: FaIcon(
      FontAwesomeIcons.shirt,
      color: Colors.black38,
    ),
    color: AppColors.green,
  ),
  Category(
    id: 8,
    title: 'Gifts',
    icon: FaIcon(
      FontAwesomeIcons.gifts,
      color: Colors.black38,
    ),
    color: AppColors.sky,
  ),
  Category(
    id: 9,
    title: 'Others',
    icon: FaIcon(
      FontAwesomeIcons.ellipsis,
      color: Colors.black38,
    ),
    color: AppColors.yellow,
  ),
];
