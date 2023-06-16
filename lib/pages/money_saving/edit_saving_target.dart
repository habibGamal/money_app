import 'package:flutter/material.dart';
import 'package:money_app/model_util/saving_targets_util.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/widgets/saving_target_form.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class EditSavingTarget extends StatelessWidget {
  const EditSavingTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    final savingTarget = ModalRoute.of(context)?.settings.arguments
        as SavingTargetWithItsRecords;
    return Scaffold(
        appBar: AppBar(
          title: TitleText(t('Edit Saving Target', 'تعديل عملية ادخار')),
        ),
        body: SavingTargetForm(
          amountOfMoney: savingTarget.savingTargetDB.target_amount.toString(),
          note: savingTarget.savingTargetDB.note!,
          noOfMonths: savingTarget.savingTargetDB.no_of_months!,
          startDate: savingTarget.savingTargetDB.start_date!,
          targetName: savingTarget.savingTargetDB.target_name!,
          onSave: (
            targetName,
            noOfMonths,
            note,
            startDate,
            amountOfMoney,
          ) async {
            savingTarget.savingTargetDB.target_amount =
                double.parse(amountOfMoney);
            savingTarget.savingTargetDB.note = note;
            savingTarget.savingTargetDB.no_of_months = noOfMonths;
            savingTarget.savingTargetDB.start_date = startDate;
            savingTarget.savingTargetDB.target_name = targetName;
            await savingTarget.savingTargetDB.save();
            Provider.of<MoneySavingState>(context, listen: false)
                .refreshTargets();
            Navigator.of(context).pop();
          },
        ));
  }
}
