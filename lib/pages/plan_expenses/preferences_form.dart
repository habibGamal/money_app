import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/styles/dropdown_style_data.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class PreferencesForm extends StatefulWidget {
  const PreferencesForm({
    super.key,
  });

  @override
  State<PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  submitForm() {
    Plan.plan.applyPreferences();
    Plan.plan.applyMode();
    Plan.plan.turnPercentsToValues();
    Provider.of<AppState>(context, listen: false)
        .updatePlanInDB(Plan.plan.planAsMap);
    Navigator.of(context).pushReplacementNamed('/plan-expenses/plan');
  }

  _showToast(bool isAr) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 222, 137, 131),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.xmark),
          SizedBox(
            width: 12.0,
          ),
          isAr
              ? FittedBox(child: NormalText('لا يمكن تجنب هذا العنصر'))
              : NormalText('This item cannot be avoided'),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  bool get hasChildren => Plan.plan.planInputData!.numberOfChildren > 0;
  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final isAr = t(false, true);
    return Scaffold(
      appBar: AppBar(
        title: NormalText(t('Preferences', 'التفضيلات')),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField2<PlanMode>(
              value: Plan.plan.planMode,
              onChanged: (newValue) {
                if (newValue == null) return;
                Plan.plan.planItems
                    .where((element) => element.appear)
                    .forEach((element) => element.active = true);
                Plan.plan.setPlanMode = newValue;
                setState(() {});
              },
              items: [
                DropdownMenuItem(
                  value: PlanMode.balanced,
                  child: NormalText(t('Balanced', 'متوازن')),
                ),
                DropdownMenuItem(
                  value: PlanMode.nutration,
                  child: NormalText(t('Nutration', 'تغذية')),
                ),
                DropdownMenuItem(
                  value: PlanMode.saving,
                  child: NormalText(t('Saving', 'توفير')),
                ),
                if (hasChildren)
                  DropdownMenuItem(
                    value: PlanMode.educationChildren,
                    child: NormalText(
                        t('Education & Children', 'التعليم و الأطفال')),
                  ),
                DropdownMenuItem(
                  value: PlanMode.aethetics,
                  child: NormalText(t('Aethetics', 'جماليات')),
                ),
              ],
              decoration: appInputDecoration(
                t('Plan Mode', 'نمط الخطة'),
                context,
              ),
              dropdownStyleData: dropDownstyleData,
              validator: (value) {
                if (value == null) {
                  return isAr ? 'برجاء اختيار خيار' : 'Please select an option';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ...Plan.plan.planItems
                .where((element) => element.appear)
                .map(
                  (item) => CheckboxListTile(
                    title: NormalText(t(item.englishName, item.arabicName)),
                    value: item.active,
                    onChanged: (value) {
                      if (value == false &&
                          !Plan.plan.validatePreferences(item.category)) {
                        _showToast(isAr);
                        return;
                      }
                      setState(() {
                        item.active = value!;
                      });
                    },
                  ),
                )
                .toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/plan-expenses/form'),
                    child: NormalText(t('Back', 'رجوع')),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: submitForm,
                    child: NormalText(t('Next', 'التالي')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
