import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/model_util/saving_targets_util.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/styles/app_input_decoration.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_card.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/gray_bold_text.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/keyboard_dismiss.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/title_text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class TrackProgressOfSaving extends StatefulWidget {
  const TrackProgressOfSaving({super.key});

  @override
  State<TrackProgressOfSaving> createState() => _TrackProgressOfSavingState();
}

class _TrackProgressOfSavingState extends State<TrackProgressOfSaving> {
  updateTargets() {
    Provider.of<MoneySavingState>(context, listen: false).refreshTargets();
  }

  listRecords(SavingTargetWithItsRecords target) {
    final locale = Provider.of<AppState>(context).language;
    final list = target.targetRecords
        .map(
          (e) => ListTile(
            title: BoldText(
              '\$${e.amount}',
              canTranlate: false,
            ),
            subtitle:
                GrayText(DateFormat('d MMM yyyy', locale).format(e.date!)),
            trailing: SizedBox(
              width: 100,
              height: 100,
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (context) {
                          return ProgressForm(
                            amount: e.amount.toString(),
                            date: e.date!,
                            onSave: (amount, date) async {
                              e.amount = double.parse(amount);
                              e.date = date;
                              e.save();
                              updateTargets();
                            },
                          );
                        });
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    e.delete();
                    updateTargets();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]),
            ),
          ),
        )
        .toList();
    final List<Widget> listWithDivider = [];
    int i = 1;
    for (ListTile item in list) {
      listWithDivider.add(item);
      if (i != list.length && list.length != 1) {
        listWithDivider.add(const Divider());
      }
      i++;
    }
    return listWithDivider;
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final savingTargetId = (ModalRoute.of(context)!.settings.arguments
            as SavingTargetWithItsRecords)
        .savingTargetDB
        .id;
    // to make this widget updated with provider not with the parameter as the parameter is not updated
    final savingTarget = Provider.of<MoneySavingState>(context)
        .savingTargets
        .firstWhere((element) => element.savingTargetDB.id == savingTargetId);
    return Scaffold(
      appBar: AppBar(
        title: TitleText(t('Track Progress of Saving', 'تتبع عملية الادخار')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            AppCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldText(savingTarget.savingTargetDB.target_name!),
                      GrayText(savingTarget.progress),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          lineHeight: 6,
                          percent: savingTarget.percent,
                          animation: true,
                          isRTL: t(false, true),
                          barRadius: const Radius.circular(16),
                          backgroundColor: Colors.grey[200],
                          progressColor: savingTarget.percent >= 1
                              ? AppColors.green
                              : AppColors.yellow,
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                          flex: 1,
                          child: FittedBox(
                              child: GrayBoldText(
                                  '${(savingTarget.percent * 100).toStringAsFixed(0)}%'))),
                    ],
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (context) {
                            return ProgressForm(
                              amount: '',
                              date: DateTime.now(),
                              onSave: (amount, date) async {
                                await SavingTargetRecord.withFields(
                                        double.parse(amount),
                                        date,
                                        savingTarget.savingTargetDB.id)
                                    .save();
                                updateTargets();
                              },
                            );
                          })
                    },
                child: NormalText(t('Add Money', 'اضافة نقود'))),
            const SizedBox(height: 20),
            AppCard(
              child: Column(children: [
                ...listRecords(savingTarget),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/money-saving/edit-target',
                      arguments: savingTarget);
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressForm extends StatefulWidget {
  final String amount;
  final DateTime date;
  final Function(String amount, DateTime date) onSave;
  const ProgressForm(
      {required this.amount,
      required this.date,
      required this.onSave,
      super.key});

  @override
  State<ProgressForm> createState() => _ProgressFormState();
}

class _ProgressFormState extends State<ProgressForm> {
  late String _amount = widget.amount;
  late DateTime _date = widget.date;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final locale = Provider.of<AppState>(context).language;
    final isAr = t(false, true);
    return KeyboardDismiss(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) {
                    _amount = newValue;
                  }
                },
                initialValue: _amount,
                keyboardType: TextInputType.number,
                decoration: appInputDecoration(
                    t('Add money you gain', 'كمية النقود'), context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isAr
                        ? 'برجاء اضافة كمية النقود'
                        : 'Please enter the amount of money that you want to add';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
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
                        _date = date!;
                      },
                      child: NormalText(t('Choose Date', 'اختر التاريخ')),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onSave(_amount, _date);
                      Navigator.pop(context);
                    }
                  },
                  child: NormalText(t('Submit', 'تم')))
            ],
          ),
        ),
      ),
    );
  }
}
