import 'package:flutter/material.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/model_util/saving_targets_util.dart';

class MoneySavingState extends ChangeNotifier {
  List<SavingTargetWithItsRecords> _savingTargets = [];
  List<SavingTargetWithItsRecords> get savingTargets => _savingTargets;
  refreshTargets() async {
    final targetsDB = await SavingTarget().select().toList();
    _savingTargets =
        await SavingTargetsUtil(targetsDB).savingTargetsWithItsRecords;
    notifyListeners();
  }
}
