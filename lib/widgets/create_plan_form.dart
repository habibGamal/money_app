import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/styles/dropdown_style_data.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/normal_text.dart';

class InfoForm extends StatefulWidget {
  final void Function({List<PlanCategory>? plan}) nextDisplay;
  const InfoForm(this.nextDisplay, {super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  int? _age;
  String? _partnerState;
  int? _monthIncome;
  int? _numberOfChildren;
  String? _childrenState;
  String? _schoolState;

  submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final data = PlanInputData(
        gender: _gender!,
        age: _age!,
        partnerState: _partnerState!,
        monthIncome: _monthIncome!,
        numberOfChildren: _numberOfChildren!,
        childrenState: _childrenState,
        schoolState: _schoolState,
      );
      final plan = Plan(planInputData: data).createBasePlan();
      if (plan != null) widget.nextDisplay(plan: plan);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final isAr = t(false, true);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField2<String>(
              value: _gender,
              onChanged: (newValue) {
                _gender = newValue;
              },
              onSaved: (newValue) {
                _gender = newValue;
              },
              items: [
                DropdownMenuItem(
                  value: 'male',
                  child: NormalText(t('Male', 'ذكر')),
                ),
                DropdownMenuItem(
                  value: 'female',
                  child: NormalText(t('Female', 'أنثى')),
                ),
              ],
              decoration: appInputDecoration(
                t('Gender', 'الجنس'),
                context,
              ),
              dropdownStyleData: dropDownstyleData,
              validator: (value) {
                // print("value $value");
                if (value == null || value.isEmpty) {
                  return isAr
                      ? 'برجاء إدخال الجنس'
                      : 'Please enter your Gender';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              // onChanged: (newValue) {
              //   _age = int.parse(newValue);
              // },
              onSaved: (newValue) {
                _age = int.parse(newValue!);
              },
              keyboardType: TextInputType.number,
              decoration: appInputDecoration(
                t('Age', 'العمر'),
                context,
              ),
              validator: (value) {
                print('should vaidate $value');
                if (value == null || value.isEmpty) {
                  return isAr ? 'برجاء إدخال العمر' : 'Please enter your age';
                }
                if (int.tryParse(value) == null) {
                  return isAr
                      ? 'برجاء إدخال عمر صحيح'
                      : 'Please enter a valid age';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField2<String>(
              value: _partnerState,
              onChanged: (newValue) {
                setState(() {
                  _partnerState = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'work',
                  child: NormalText(t('Working', 'يعمل')),
                ),
                DropdownMenuItem(
                  value: 'not_working',
                  child: NormalText(t('Not Working', 'لا يعمل')),
                ),
              ],
              decoration: appInputDecoration(
                t('Partner State', 'حالة الشريك (الزوج / الزوجة)'),
                context,
              ),
              dropdownStyleData: dropDownstyleData,
              validator: (value) {
                if (value == null) {
                  return isAr
                      ? 'يرجى تحديد حالة الشريك'
                      : 'Please select a partner state';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (newValue) {
                _monthIncome = int.parse(newValue);
              },
              keyboardType: TextInputType.number,
              decoration: appInputDecoration(
                t('Monthly Income', 'الدخل الشهري'),
                context,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return isAr
                      ? 'برجاء إدخال الدخل الشهري'
                      : 'Please enter your monthly income';
                }
                final income = int.tryParse(value);
                if (income == null) {
                  return isAr
                      ? 'برجاء إدخال دخل شهري صحيح'
                      : 'Please enter a valid monthly income';
                }
                if (income < 5000 || income > 20000) {
                  return isAr
                      ? 'يجب أن يكون الدخل الشهري بين 5000 و 20000'
                      : 'Monthly income should be between 5000 and 20000';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField2<String>(
              value: _numberOfChildren?.toString(),
              onChanged: (newValue) {
                if (newValue == null) return;
                setState(() {
                  _numberOfChildren = int.tryParse(newValue);
                  if (_numberOfChildren == 0) {
                    Plan.getCategory('educationChildren')?.disappearItems();
                  } else {
                    Plan.getCategory('educationChildren')?.appearItems();
                  }
                });
              },
              items: [
                DropdownMenuItem(
                  value: '0',
                  child: NormalText(t('Does not have', 'لا يوجد')),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: NormalText(t('One', 'واحد')),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: NormalText(t('Two', 'اثنان')),
                ),
              ],
              decoration: appInputDecoration(
                t('Number of Children', 'عدد الأطفال'),
                context,
              ),
              dropdownStyleData: dropDownstyleData,
            ),
            const SizedBox(
              height: 30,
            ),
            if (_numberOfChildren != null && _numberOfChildren! > 0)
              DropdownButtonFormField2<String>(
                value: _childrenState,
                validator: (value) {
                  if (value == null) {
                    return isAr
                        ? 'يرجى تحديد حالة الأطفال'
                        : 'Please select a children state';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _childrenState = newValue;
                    if (_childrenState == "school") {
                      Plan.getItem('diapers')?.appear = false;
                      Plan.getItem('poketMoney')?.appear = true;
                    } else {
                      Plan.getItem('diapers')?.appear = true;
                      Plan.getItem('poketMoney')?.appear = false;
                    }
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'nursery',
                    child: NormalText(t('Nursery', 'حضانة')),
                  ),
                  DropdownMenuItem(
                    value: 'school',
                    child: NormalText(t('School', 'مدرسة')),
                  ),
                ],
                decoration: appInputDecoration(
                  t('Children State', 'حالة الأطفال'),
                  context,
                ),
                dropdownStyleData: dropDownstyleData,
              ),
            const SizedBox(
              height: 30,
            ),
            if (_numberOfChildren != null &&
                _numberOfChildren! > 0 &&
                _childrenState == 'school')
              DropdownButtonFormField2<String>(
                value: _schoolState,
                validator: (value) {
                  if (value == null) {
                    return isAr
                        ? 'يرجى تحديد حالة المدرسة'
                        : 'Please select a school state';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _schoolState = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'national',
                    child: NormalText(t('National', 'وطني')),
                  ),
                  DropdownMenuItem(
                    value: 'international',
                    child: NormalText(t('International', 'دولي')),
                  ),
                  DropdownMenuItem(
                    value: 'government',
                    child: NormalText(t('Government', 'حكومي')),
                  ),
                ],
                decoration: appInputDecoration(
                  t('School State', 'حالة المدرسة'),
                  context,
                ),
                dropdownStyleData: dropDownstyleData,
              ),
            ElevatedButton(
                onPressed: submitForm,
                child: NormalText(t('Create Plan', 'إنشاء الخطة'))),
          ],
        ),
      ),
    );
  }
}

class PreferencesForm extends StatefulWidget {
  final void Function({List<PlanCategory>? plan}) nextDisplay;
  final void Function() previousDisplay;
  final List<PlanCategory> plan;

  const PreferencesForm(
    this.nextDisplay,
    this.previousDisplay, {
    required this.plan,
    super.key,
  });

  @override
  State<PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  submitForm() {
    widget.plan.applyPreferences();
    widget.nextDisplay(plan: widget.plan);
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return ListView(
      children: [
        ...Plan.planItems
            .where((element) => element.appear)
            .map(
              (item) => CheckboxListTile(
                title: NormalText(t(item.englishName, item.arabicName)),
                value: item.active,
                onChanged: (value) {
                  setState(() {
                    item.active = value!;
                  });
                },
              ),
            )
            .toList(),
        ElevatedButton(
          onPressed: submitForm,
          child: NormalText(t('Next', 'التالي')),
        ),
      ],
    );
  }
}
