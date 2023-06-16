import 'package:flutter/material.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/keyboard_dismiss.dart';
import 'package:money_app/widgets/record_form.dart';
import 'package:provider/provider.dart';

class EditRecordPage extends StatelessWidget {
  const EditRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final Record record =
        ModalRoute.of(context)!.settings.arguments as Record;
    final appState = Provider.of<AppState>(context, listen: false);
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(
        title: BoldText(t('Edit the record', 'تعديل')),
      ),
      body: KeyboardDismiss(
        child: RecordForm(
          amount: record.amount.toString(),
          note: record.note!,
          date: record.date!,
          selectedCategory: record.category_id!,
          snackBarText: t("Record Updated Successfully", "تم التعديل بنجاح"),
          onSave: (amount, note, date, selectedCategory, recordType) {
            record.amount = double.parse(amount);
            record.note = note;
            record.date = date;
            record.category_id = selectedCategory;
            record.type = recordType;
            record.save();
            appState.refreshRecords();
          },
        ),
      ),
    );
  }
}
