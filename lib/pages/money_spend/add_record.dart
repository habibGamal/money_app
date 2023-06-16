import 'package:flutter/material.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/adjust_layout_direction.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/keyboard_dismiss.dart';
import 'package:money_app/widgets/record_form.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatelessWidget {
  const AddRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(
        title: BoldText(t('Add record', 'اضافة')),
      ),
      body: KeyboardDismiss(
        child: AdjustLayoutDirection(
          child: RecordForm(
            amount: '',
            note: '',
            date: DateTime.now(),
            selectedCategory: 1,
            snackBarText: t("Record Added Successfully", 'تم الاضافة بنجاح'),
            onSave: (amount, note, date, selectedCategory, recordType) async {
              await Record.withFields(
                recordType,
                double.parse(amount),
                selectedCategory,
                note,
                date,
              ).save();
              appState.refreshRecords();
            },
          ),
        ),
      ),
    );
  }
}
