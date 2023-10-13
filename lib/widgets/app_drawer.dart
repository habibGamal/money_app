import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:provider/provider.dart';

import 'drawer_item.dart';
import 'normal_text.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final t = translate(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Row(children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/logo.jpg'),
                  // backgroundColor: Colors.amber,
                ),
                const SizedBox(width: 10),
                NormalText(t("Spend wise", "رشد ووفر")),
              ]),
            ),
          ),
          DrawerItem(
            name: t('Plan Your Expenses', 'تخطيط مصاريفك'),
            icon: FontAwesomeIcons.clipboardList,
            callback: () {
              Navigator.of(context).pushReplacementNamed('/plan-expenses/cta');
            },
          ),
          DrawerItem(
            name: t('Money Management', 'ادارة نقودك'),
            icon: FontAwesomeIcons.moneyBillTransfer,
            callback: () {
              Navigator.of(context).pushReplacementNamed('/money-spend');
            },
          ),
          DrawerItem(
            name: t('Money Saving', 'الادخار'),
            icon: FontAwesomeIcons.moneyBillTrendUp,
            callback: () {
              Navigator.of(context).pushReplacementNamed('/money-saving');
            },
          ),
          DrawerItem(
            name: t('Who we are', 'من نحن'),
            icon: FontAwesomeIcons.handHoldingHeart,
            callback: () async {
              Navigator.of(context).pushReplacementNamed('/dedication');
            },
          ),
          DrawerItem(
            name: t('About', 'حول التطبيق'),
            icon: FontAwesomeIcons.circleInfo,
            callback: () async {
              Navigator.of(context).pushReplacementNamed('/about');
            },
          ),
          DrawerItem(
            name: t('Change theme', 'تغيير الوضع'),
            icon: FontAwesomeIcons.circleHalfStroke,
            callback: () {
              Provider.of<AppState>(context, listen: false).toggleThemeMode();
            },
          ),
          DrawerItem(
            name: t('Change language ($lang)', 'تغيير اللغة ($lang)'),
            icon: FontAwesomeIcons.language,
            callback: () async {
              Provider.of<AppState>(context, listen: false).toggleLanguage();
            },
          ),
        ],
      ),
    );
  }
}
