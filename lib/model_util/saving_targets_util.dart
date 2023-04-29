import 'package:money_app/model/model.dart';

class SavingTargetWithItsRecords {
  final SavingTarget savingTargetDB;
  late List<SavingTargetRecord> targetRecords;

  SavingTargetWithItsRecords(this.savingTargetDB, this.targetRecords);

  double get totalAmountOfSaving {
    return targetRecords.fold(
        0, (previousValue, element) => previousValue + element.amount!);
  }

  int get timeLeft {
    final lastDay = savingTargetDB.start_date!
        .add(Duration(days: 30 * savingTargetDB.no_of_months!));
    final difference = lastDay.difference(DateTime.now());
    return difference.inDays;
  }

  String get progress {
    final target = savingTargetDB.target_amount!;
    final achived = totalAmountOfSaving;
    return '\$${achived.toStringAsFixed(0)} / \$${target.toStringAsFixed(0)}';
  }

  double get percent {
    final target = savingTargetDB.target_amount!;
    final achived = totalAmountOfSaving;
    final percent = achived / target;
    if (percent > 1) return 1;
    return achived / target;
  }
}

class SavingTargetsUtil {
  final List<SavingTarget> _savingTargets;
  SavingTargetsUtil(this._savingTargets);

  Future<List<SavingTargetWithItsRecords>>
      get savingTargetsWithItsRecords async {
    final List<SavingTargetWithItsRecords> result = [];
    for (SavingTarget target in _savingTargets) {
      final records = await target.getSavingTargetRecords()?.toList() ?? [];
      result.add(SavingTargetWithItsRecords(target, records));
    }
    return result;
  }
}
