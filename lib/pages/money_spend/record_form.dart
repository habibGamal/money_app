import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model_util/category.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/category.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class RecordForm extends StatefulWidget {
  final Function(String amount, String note, DateTime date,
      int selectedCategory, bool recordType) onSave;
  final String amount;
  final String note;
  final DateTime date;
  final int selectedCategory;
  final String snackBarText;
  const RecordForm(
      {super.key,
      required this.onSave,
      required this.amount,
      required this.note,
      required this.date,
      required this.selectedCategory,
      required this.snackBarText});

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final _formKey = GlobalKey<FormState>();
  late int _selectedCategory = widget.selectedCategory;
  late String _amount = widget.amount;
  late String _note = widget.note;
  late DateTime _date = widget.date;
  final ScrollController scrollController = ScrollController();

  changeSelectedCategory(int index) {
    setState(() {
      _selectedCategory = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedCategory > 7) {
        scrollController.jumpTo(
          160,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final categoriesList = appState.currentMode == Mode.expense
        ? expenseCategories
        : incomeCategories;
    final t = translate(context);
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(
                height: appState.currentMode == Mode.expense ? 210 : 100,
                child: GridView(
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 160,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    children: [
                      ...categoriesList
                          .map((category) => CategoryCard(
                                category,
                                selectedCategory: _selectedCategory,
                                callback: changeSelectedCategory,
                              ))
                          .toList(),
                    ]),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) {
                    _amount = newValue;
                  }
                },
                initialValue: _amount,
                keyboardType: TextInputType.number,
                decoration: appInputDecoration(
                    t('Amount of money', 'كمية النقود'), context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appState.isAR
                        ? 'برجاء ادخل كمية المال التي انفقتها'
                        : 'Please enter the amount of money that you spent';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onSaved: (newValue) => {if (newValue != null) _note = newValue},
                initialValue: _note,
                decoration: appInputDecoration(
                    t('Note (optional)', 'ملاحظة (اختياري)'), context),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: t(
                    GrayText(
                        'Choosen Date : ${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}'),
                    GrayText(
                        'التاريخ : ${DateFormat('dd - MM - yyyy', 'ar').format(DateTime.now()).toString()}'),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        setState(() {
                          if (date != null) _date = date;
                        });
                      },
                      child: NormalText(t('Choose Date', 'اختر التاريخ')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(widget.snackBarText)),
                    );
                    _formKey.currentState!.save();
                    widget.onSave(
                      _amount,
                      _note,
                      _date,
                      _selectedCategory,
                      appState.currentRecordType,
                    );
                    Navigator.pop(context);
                  }
                },
                child: NormalText(t('Submit', 'تم')),
              ),
            ],
          )),
    );
  }
}
