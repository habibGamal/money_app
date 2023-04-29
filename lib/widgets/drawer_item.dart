import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/widgets/normal_text.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function callback;
  const DrawerItem({
    required this.name,
    required this.icon,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: AppColors.primary,
      ),
      title: NormalText(name),
      onTap: () {
        callback();
      },
    );
  }
}
