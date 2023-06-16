import 'package:flutter/material.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/widgets/saving_target_form.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class AddSavingTarget extends StatelessWidget {
  const AddSavingTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
        appBar: AppBar(
          title: TitleText(t('Add Saving Target', 'اضافة عملية ادخار')),
        ),
        body: SavingTargetForm(
          amountOfMoney: '',
          note: '',
          noOfMonths: 6,
          startDate: DateTime.now(),
          targetName: '',
          onSave: (
            targetName,
            noOfMonths,
            note,
            startDate,
            amountOfMoney,
          ) async {
            await SavingTarget.withFields(
              targetName,
              double.parse(amountOfMoney),
              noOfMonths,
              note,
              startDate,
            ).save();
            Provider.of<MoneySavingState>(context, listen: false)
                .refreshTargets();
          },
        ));
  }
}
