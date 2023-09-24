import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:money_app/model_util/plan.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/styles/dropdown_style_data.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/normal_text.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  int? _age;
  String? _partnerState;
  int? _monthIncome;
  int? _numberOfChildren;
  String? _childrenState;
  String? _schoolState;

  initForm() {
    final data = Plan.plan.planInputData;
    if (data == null) return;
    _age = data.age;
    _partnerState = data.partnerState;
    _monthIncome = data.monthIncome;
    _numberOfChildren = data.numberOfChildren;
    _childrenState = data.childrenState;
    _schoolState = data.schoolState;
  }

  @override
  void initState() {
    super.initState();
    initForm();
  }

  submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final data = PlanInputData(
        age: _age!,
        partnerState: _partnerState!,
        monthIncome: _monthIncome!,
        numberOfChildren: _numberOfChildren!,
        childrenState: _childrenState,
        schoolState: _schoolState,
      );
      Plan.plan.setPlanInputData = data;
      Plan.plan.createBasePlan();
      Navigator.of(context).pushNamed('/plan-expenses/preferences');
    }
  }

  bool get hasChildren => _numberOfChildren != null && _numberOfChildren! > 0;
  bool get childrenInSchool => hasChildren && _childrenState == 'school';
  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final isAr = t(false, true);
    return Scaffold(
      appBar: AppBar(
        title: NormalText(
          t('Plan Expenses', 'تخطيط المصاريف'),
        ),
      ),
      drawer: const AppDrawer(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: _age?.toString(),
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
                initialValue: _monthIncome?.toString(),
                onSaved: (newValue) {
                  _monthIncome = int.parse(newValue!);
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
                      Plan.plan
                          .getCategory(PlanCategories.educationChildren)
                          ?.disappearItems();
                    } else {
                      Plan.plan
                          .getCategory(PlanCategories.educationChildren)
                          ?.appearItems();
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
                  // DropdownMenuItem(
                  //   value: '2',
                  //   child: NormalText(t('Two', 'اثنان')),
                  // ),
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
              if (hasChildren)
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
                        Plan.plan.getItem('diapers')?.appear = false;
                        Plan.plan.getItem('poketMoney')?.appear = true;
                      } else {
                        Plan.plan.getItem('diapers')?.appear = true;
                        Plan.plan.getItem('poketMoney')?.appear = false;
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
              if (hasChildren)
                const SizedBox(
                  height: 30,
                ),
              if (childrenInSchool)
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
                      child: NormalText('National'),
                    ),
                    DropdownMenuItem(
                      value: 'international',
                      child: NormalText('International'),
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
              if (childrenInSchool)
                const SizedBox(
                  height: 30,
                ),
              ElevatedButton(
                  onPressed: submitForm,
                  child: NormalText(t('Create Plan', 'إنشاء الخطة'))),
            ],
          ),
        ),
      ),
    );
  }
}
