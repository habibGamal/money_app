import 'package:flutter/material.dart';
import 'package:money_app/model_util/records_util.dart';
import 'package:money_app/notifiers/app_state.dart';
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: record.category.color,
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: record.category.icon),
      ),
      title: NormalText(record.category.title),
      subtitle: record.note != ''
          ? GrayText(record.note!)
          : const GrayText('No notes'),
      trailing: NormalText('\$ ${record.amount.toString()}'),
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
                      children: const [
                        Icon(Icons.delete),
                        Text('Delete'),
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
