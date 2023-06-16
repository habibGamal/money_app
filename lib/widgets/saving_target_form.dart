import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';

class SavingTargetForm extends StatefulWidget {
  final String targetName;
  final int noOfMonths;
  final String note;
  final DateTime startDate;
  final String amountOfMoney;
  final Function onSave;
  const SavingTargetForm({
    super.key,
    required this.targetName,
    required this.noOfMonths,
    required this.note,
    required this.startDate,
    required this.amountOfMoney,
    required this.onSave,
  });

  @override
  State<SavingTargetForm> createState() => _SavingTargetFormState();
}

class _SavingTargetFormState extends State<SavingTargetForm> {
  final _formKey = GlobalKey<FormState>();
  late String _targetName = widget.targetName;
  late int _noOfMonths = widget.noOfMonths;
  late String _note = widget.note;
  late DateTime _startDate = widget.startDate;
  late String _amountOfMoney = widget.amountOfMoney;

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
              TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) {
                    _targetName = newValue;
                  }
                },
                initialValue: _targetName,
                decoration: appInputDecoration(
                    t('The target ex:( Buy new phone )',
                        'هدف الادخار مثال: (شراء هاتف جديد)'),
                    context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isAr
                        ? 'برجاء ادخل هدف الادخار'
                        : 'Please enter the target name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) {
                    _amountOfMoney = newValue;
                  }
                },
                initialValue: _amountOfMoney,
                keyboardType: TextInputType.number,
                decoration: appInputDecoration(
                    t('The amount you need to save',
                        'كمية النقود الازمة للادخار'),
                    context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isAr
                        ? 'برجاء ادخل كمية النقود الازمة للادخار'
                        : 'Please enter the amount of money that you want to save';
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
                        'Choosen Date : ${DateFormat('yyyy-MM-dd').format(_startDate).toString()}'),
                    GrayText(
                        'التاريخ : ${DateFormat('dd - MM - yyyy', 'ar').format(_startDate).toString()}'),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        setState(() {
                          if (date != null) _startDate = date;
                        });
                      },
                      child: NormalText(t('Start Date', 'تاريخ البدء')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: appInputDecoration(
                    t('No of months', 'عدد الاشهر'), context),
                icon: const Icon(Icons.calendar_month),
                items: [
                  ...List.generate(48, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: NormalText(t('$e Months', '$e اشهر')),
                          ))
                      .toList(),
                ],
                value: _noOfMonths,
                onChanged: (value) => _noOfMonths = value as int,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text(widget.snackBarText)),
                    // );
                    _formKey.currentState!.save();
                    widget.onSave(
                      _targetName,
                      _noOfMonths,
                      _note,
                      _startDate,
                      _amountOfMoney,
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
