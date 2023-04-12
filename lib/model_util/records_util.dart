import 'package:intl/intl.dart';
import 'package:money_app/model_util/category.dart';
import 'package:money_app/model_util/record_type.dart';

import '../model/model.dart';

class RecordWithCategory {
  final Record recordDB;
  int? id;
  bool? type;
  double? amount;
  // ignore: non_constant_identifier_names
  int? category_id;
  String? note;
  DateTime? date;

  RecordWithCategory(this.recordDB) {
    id = recordDB.id;
    type = recordDB.type;
    amount = recordDB.amount;
    category_id = recordDB.category_id;
    note = recordDB.note;
    date = recordDB.date;
  }

  getCategoryFrom(List<Category> categories) {
    return categories
        .firstWhere((category) => category.id == recordDB.category_id);
  }

  get category {
    if (recordDB.type == RecordType.expense) {
      return getCategoryFrom(expenseCategories);
    }
    return getCategoryFrom(incomeCategories);
  }
}

class RecordsByDay {
  final String _day;

  final List<RecordWithCategory> records;

  double get totalAmount {
    double total = 0;
    for (RecordWithCategory record in records) {
      total += record.amount!;
    }
    return total;
  }

  get day {
    // if it's today, return 'Today'
    if (DateFormat('dd MMM').format(DateTime.now()) == _day) {
      return 'Today';
    }
    // if it's yesterday, return 'Yesterday'
    if (DateFormat('dd MMM')
            .format(DateTime.now().subtract(const Duration(days: 1))) ==
        _day) {
      return 'Yesterday';
    }
    return _day;
  }

  RecordsByDay(this._day, this.records);
}

class RecordsByCategory {
  final Category category;
  final List<RecordWithCategory> records;
  final double totalAmountOfAllRecords;

  double get totalAmount {
    double total = 0;
    for (RecordWithCategory record in records) {
      total += record.amount!;
    }
    return total;
  }

  double get percentage {
    return (totalAmount / totalAmountOfAllRecords) * 100;
  }

  RecordsByCategory(this.category, this.records, this.totalAmountOfAllRecords);
}

class RecordsUtil {
  final List<Record> rawRecords;
  const RecordsUtil(this.rawRecords);

  List<RecordWithCategory> get records {
    return rawRecords.map((record) => RecordWithCategory(record)).toList();
  }

  double get totalAmountOfAllRecords {
    double total = 0;
    for (RecordWithCategory record in records) {
      total += record.amount!;
    }
    return total;
  }

  List<RecordsByDay> get recordsByDays {
    final records = this.records;
    final recordsByDaysMap = <String, List<RecordWithCategory>>{};

    for (RecordWithCategory record in records) {
      final date = record.date!;
      final day = DateFormat('dd MMM').format(date);
      if (recordsByDaysMap[day] == null) {
        recordsByDaysMap[day] = [record];
      } else {
        recordsByDaysMap[day]!.add(record);
      }
    }
    // map recordsByDays to RecordsByDay
    final List<RecordsByDay> recordsByDays = [];
    for (String day in recordsByDaysMap.keys) {
      recordsByDays.add(RecordsByDay(day, recordsByDaysMap[day]!));
    }

    return recordsByDays;
  }

  List<RecordsByCategory> get recordsByCategories {
    final records = this.records;
    final recordsByCategoriesMap = <int, List<RecordWithCategory>>{};

    for (RecordWithCategory record in records) {
      final categoryId = record.category_id!;
      if (recordsByCategoriesMap[categoryId] == null) {
        recordsByCategoriesMap[categoryId] = [record];
      } else {
        recordsByCategoriesMap[categoryId]!.add(record);
      }
    }
    // map recordsByCategories to RecordsByCategory
    final List<RecordsByCategory> recordsByCategories = [];
    for (int categoryId in recordsByCategoriesMap.keys) {
      final records = recordsByCategoriesMap[categoryId]!;
      final category = records.first.category;
      recordsByCategories
          .add(RecordsByCategory(category, records, totalAmountOfAllRecords));
    }

    return recordsByCategories;
  }
}
