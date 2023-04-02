import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import './category.dart';

class Record {
  final Category category;
  final String? subtitle;
  final String value;
  const Record({
    required this.category,
    required this.value,
    this.subtitle,
  });
}

final records = [
  Record(
    category: categories[0],
    subtitle: 'Today',
    value: '\$ 500',
  ),
  Record(
    category: categories[1],
    subtitle: 'Today',
    value: '\$ 200',
  ),
  Record(
    category: categories[2],
    subtitle: 'Today',
    value: '\$ 100',
  ),
  Record(
    category: categories[3],
    subtitle: 'Today',
    value: '\$ 50',
  ),
  Record(
    category: categories[4],
    subtitle: 'Today',
    value: '\$ 50',
  ),
];
