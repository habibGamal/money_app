import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/styles/dropdown_style_data.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/create_plan_form.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/title_text.dart';

class PlanExpenses extends StatefulWidget {
  const PlanExpenses({super.key});

  @override
  State<PlanExpenses> createState() => _PlanExpensesState();
}

class _PlanExpensesState extends State<PlanExpenses> {
  int currentDisplayIndex = 0;
  List<PlanCategory>? plan;
  void nextDisplay({List<PlanCategory>? plan}) {
    this.plan = plan;
    currentDisplayIndex++;
    setState(() {});
  }

  void previousDisplay() {
    setState(() {
      currentDisplayIndex--;
    });
  }

  late final List<Widget Function()> _displayList = [
    () => CTADisplay(nextDisplay),
    () => InfoForm(nextDisplay),
    () => PreferencesForm(nextDisplay, previousDisplay, plan: plan!),
    () => DisplayPlan(previousDisplay, plan: plan!),
  ];

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: TitleText(t('Plan Your Expenses', 'تخطيط مصاريفك')),
      ),
      body: _displayList[currentDisplayIndex](),
    );
  }
}

class CTADisplay extends StatelessWidget {
  final void Function({List<PlanCategory>? plan}) nextDisplay;
  const CTADisplay(
    this.nextDisplay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = translate(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/plan_expenses.png'),
          Container(
            margin: const EdgeInsets.all(30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                nextDisplay();
              },
              child: NormalText(t('Create Plan', 'انشئ خطة')),
            ),
          )
        ],
      ),
    );
  }
}

class DisplayPlan extends StatelessWidget {
  final Function previousDisplay;
  final List<PlanCategory> plan;
  const DisplayPlan(
    this.previousDisplay, {
    required this.plan,
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
      title: NormalText(title),
      tileColor: Colors.grey[200],
    );
  }

  List<Widget> _buildPlanUI(BuildContext context) {
    List<Widget> children = [];
    double total = 0;
    final t = translate(context);
    for (PlanCategory category in plan) {
      children.add(_buildCategoryTile(
          category.icon, t(category.englishName, category.arabicName)));
      for (PlanItem item in category.items) {
        total += item.value;
        children.add(_buildListTile(
            item.icon,
            t(item.englishName, item.arabicName),
            item.value.toStringAsFixed(1)));
      }
    }
    print(total);
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return ListView(
      children: [
        ..._buildPlanUI(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
              onPressed: () => previousDisplay(),
              child: NormalText(t('Create New Plan', 'إنشاء خطة جديدة'))),
        ),
      ],
    );
  }
}
