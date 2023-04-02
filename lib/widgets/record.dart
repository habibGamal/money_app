import 'package:flutter/material.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/gray_text.dart';
import '../models/record.dart';

class RecordTile extends StatelessWidget {
  final Record item;
  const RecordTile(
    this.item, {
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
          color: item.category.color,
          borderRadius: BorderRadius.circular(10000),
        ),
        child: Center(child: item.category.icon),
      ),
      title: NormalText(item.category.title),
      subtitle: item.subtitle != null ? GrayText(item.subtitle!) : null,
      trailing: NormalText(item.value),
      onTap: () => {},
    );
  }
}
