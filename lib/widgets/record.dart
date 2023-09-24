import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/LTR_only.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:provider/provider.dart';

class RecordTile extends StatelessWidget {
  final RecordWithCategory record;
  const RecordTile(
    this.record, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: record.category.getColor(context),
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: record.category.icon),
      ),
      title: NormalText(t(record.category.title, record.category.titleAr)),
      // subtitle: record.note != ''
      //     ? GrayText(record.note!)
      //     : GrayText(t('No notes', 'لا يوجد ملاحظات')),
      trailing: LTROnly(
        child: NormalText(
          '\$ ${record.amount.toString()}',
          canTranlate: false,
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(
          context,
          '/money-spend/edit-record',
          arguments: record.recordDB,
        )
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: 75,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete),
                        SizedBox(width: 10),
                        NormalText(t('Delete', 'حذف')),
                      ],
                    ),
                    onPressed: () {
                      record.recordDB.delete();
                      Provider.of<AppState>(context, listen: false)
                          .refreshRecords();
                      Navigator.pop(context);
                    },
                  ));
            });
      },
    );
  }
}
