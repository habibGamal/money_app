import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class CTADisplay extends StatefulWidget {
  const CTADisplay({
    super.key,
  });

  @override
  State<CTADisplay> createState() => _CTADisplayState();
}

class _CTADisplayState extends State<CTADisplay> {
  bool _hasPlan = false;
  @override
  void initState() {
    super.initState();
    checkPlanInDB();
  }

  checkPlanInDB() async {
    await Provider.of<AppState>(context, listen: false).initLangFromDB();
    final plan = Provider.of<AppState>(context, listen: false).plan;
    if (plan == null) return;
    final planMap = jsonDecode(plan) as Map<String, dynamic>;
    if (planMap.isEmpty) return;
    final Map<String, double> typedPlanMap =
        planMap.map((key, value) => MapEntry(key, value.toDouble()));
    Plan.plan.initPlanFromDB(typedPlanMap);
    _hasPlan = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(
        title: NormalText(t('Plan Expenses', 'خطة المصاريف')),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/plan_expenses.png'),
            Container(
              margin: const EdgeInsets.all(30),
              child: _hasPlan
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed('/plan-expenses/plan'),
                            child: NormalText(t('Show Plan', 'عرض الخطة')),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _createPlan(t),
                        ),
                      ],
                    )
                  : _createPlan(t),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _createPlan(t) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/plan-expenses/form');
      },
      child: NormalText(t('Create Plan', 'انشئ خطة')),
    );
  }
}
