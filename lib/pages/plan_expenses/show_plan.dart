import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/medium_text.dart';
import 'package:money_app/widgets/normal_text.dart';

class ShowPlan extends StatelessWidget {
  const ShowPlan({
    super.key,
  });

  Widget _buildListTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: NormalText(title),
      trailing: Text(value),
    );
  }

  Widget _buildCategoryTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.green,
        size: 30,
      ),
      title: MediumText(title),
      tileColor: Colors.black12,
    );
  }

  List<Widget> _buildPlanUI(BuildContext context) {
    List<Widget> children = [];
    double total = 0;
    final t = translate(context);
    for (PlanCategory category in Plan.plan.categories) {
      children.add(_buildCategoryTile(
          category.icon, t(category.englishName, category.arabicName)));
      for (PlanItem item in category.items) {
        total += item.value;
        children.add(_buildListTile(
            item.icon,
            t(item.englishName, item.arabicName),
            item.value.toStringAsFixed(0)));
      }
    }
    print(total);
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(title: NormalText(t('Plan', 'الخطة'))),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          ..._buildPlanUI(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/plan-expenses/form'),
                child: NormalText(t('Create New Plan', 'إنشاء خطة جديدة'))),
          ),
        ],
      ),
    );
  }
}
