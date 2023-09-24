import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const minItemsInBalanced = 6;
const minItemsInAnyMode = 2;
const decreaseAmountInOtherModes = .01;
const lowerAmountLimitOfItem = .02;

enum PlanMode {
  balanced,
  nutration,
  aethetics,
  educationChildren,
  saving,
}

enum PlanCategories {
  nutration,
  aethetics,
  educationChildren,
  saving,
  others,
}

class PlanInputData {
  final int _age;
  final String _partnerState;
  final int _monthIncome;
  final int _numberOfChildren;
  final String? _childrenState;
  final String? _schoolState;

  PlanInputData({
    required int age,
    required String partnerState,
    required int monthIncome,
    required int numberOfChildren,
    required String? childrenState,
    required String? schoolState,
  })  : _age = age,
        _partnerState = partnerState,
        _monthIncome = monthIncome,
        _numberOfChildren = numberOfChildren,
        _childrenState = childrenState,
        _schoolState = schoolState;

  int get age => _age;
  String get partnerState => _partnerState;
  int get monthIncome => _monthIncome;
  int get numberOfChildren => _numberOfChildren;
  String? get childrenState => _childrenState;
  String? get schoolState => _schoolState;
}

class Plan {
  static final _instance = Plan();
  static Plan get plan => _instance;

  PlanMode _planMode = PlanMode.balanced;
  get planMode => _planMode;
  set setPlanMode(PlanMode planMode) => _planMode = planMode;

  PlanInputData? _planInputData;

  PlanInputData? get planInputData => _planInputData;
  set setPlanInputData(PlanInputData planInputData) =>
      _planInputData = planInputData;

  final List<PlanCategory> categories = [
    NutrationCategory(),
    AetheticsCategory(),
    EducationChildrenCategory(),
    SavingCategory(),
    OthersCategory(),
  ];

  List<PlanItem> get planItems {
    final List<PlanItem> items = [];
    for (PlanCategory category in categories) {
      items.addAll(category.items);
    }
    return items;
  }

  Map<String, double> get planAsMap {
    final Map<String, double> planMap = {};
    for (PlanItem item in planItems) {
      planMap[item.id] = item.value;
    }
    return planMap;
  }

  PlanItem? getItem(String id) {
    for (PlanItem item in planItems) {
      if (item.id == id) return item;
    }
    return null;
  }

  PlanCategory? getCategory(PlanCategories id) {
    for (PlanCategory category in categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  int get numberOfAllActiveItems {
    int count = 0;
    for (PlanItem item in planItems) {
      if (item.active) count++;
    }
    return count;
  }

  List<PlanItem> getActiveItems() {
    final List<PlanItem> activeItems = [];
    for (PlanItem item in planItems) {
      if (item.active && item.appear) activeItems.add(item);
    }
    return activeItems;
  }

  List<PlanItem> getDeactivatedItems() {
    final List<PlanItem> deactivatedItems = [];
    for (PlanItem item in planItems) {
      if (!item.active) deactivatedItems.add(item);
    }
    return deactivatedItems;
  }

  Map<String, double>? determineBasePlanSchema() {
    if (planInputData == null) return null;
    final noChildren = planInputData!._numberOfChildren == 0;
    if (noChildren) return basePlanNoChild;
    final nursery = planInputData!._childrenState == 'nursery';
    if (nursery) return basePlanNursery;
    final school = planInputData!._childrenState == 'school';
    if (school) return basePlanSchool;
    return null;
  }

  distributePercentsOverPlanItems(Map<String, double> plan) {
    for (PlanItem item in planItems) {
      if (plan.containsKey(item.id)) item.percent = plan[item.id]!;
    }
  }

  turnPercentsToValues() {
    for (PlanItem item in planItems) {
      item.value = item.percent * planInputData!.monthIncome;
    }
  }

  Plan? createBasePlan() {
    final plan = determineBasePlanSchema();
    if (plan == null) return null;
    distributePercentsOverPlanItems(plan);
    return this;
  }

  bool validatePreferences(PlanCategories category) {
    if (planMode == PlanMode.balanced) {
      return numberOfAllActiveItems >= minItemsInBalanced;
    }
    if (planMode == PlanMode.nutration &&
        category == PlanCategories.nutration) {
      return getCategory(PlanCategories.nutration)!.numberOfActiveItems >=
          minItemsInAnyMode;
    }
    if (planMode == PlanMode.saving && category == PlanCategories.saving) {
      return getCategory(PlanCategories.saving)!.numberOfActiveItems >=
          minItemsInAnyMode;
    }
    if (planMode == PlanMode.aethetics &&
        category == PlanCategories.aethetics) {
      return getCategory(PlanCategories.aethetics)!.numberOfActiveItems >=
          minItemsInAnyMode;
    }
    if (planMode == PlanMode.educationChildren &&
        category == PlanCategories.educationChildren) {
      return getCategory(PlanCategories.educationChildren)!
              .numberOfActiveItems >=
          minItemsInAnyMode;
    }
    return numberOfAllActiveItems >= minItemsInBalanced;
  }

  _promoteCategory(PlanCategories category) {
    // get all categories other that nutration
    final otherCategories =
        categories.where((category) => category.id != category);

    // take .01 percent from each item in other categories and add it to selected category items
    double residuePercentsOfOtherCats = 0;
    for (PlanCategory category in otherCategories) {
      final items = category.items.where((item) => item.active);
      for (PlanItem item in items) {
        if (item.percent <= lowerAmountLimitOfItem) continue;
        item.percent -= decreaseAmountInOtherModes;
        residuePercentsOfOtherCats += decreaseAmountInOtherModes;
      }
    }

    // distribute over target category
    final targetCategory =
        getCategory(category)!.items.where((item) => item.active);
    final increasePercent = residuePercentsOfOtherCats / targetCategory.length;
    for (PlanItem item in targetCategory) {
      item.percent += increasePercent;
    }
  }

  applyMode() {
    switch (planMode) {
      case PlanMode.balanced:
        return this;
      case PlanMode.nutration:
        _promoteCategory(PlanCategories.nutration);
        return this;
      case PlanMode.saving:
        _promoteCategory(PlanCategories.saving);
        return this;
      case PlanMode.aethetics:
        _promoteCategory(PlanCategories.aethetics);
        return this;
      case PlanMode.educationChildren:
        _promoteCategory(PlanCategories.educationChildren);
        return this;
      default:
        return this;
    }
  }

  applyPreferences() {
    double residuePercentsOfDeactivatedItems = 0;
    getDeactivatedItems().forEach((item) => {
          residuePercentsOfDeactivatedItems += item.percent,
          item.percent = 0,
        });
    final activeItems = getActiveItems();
    final increasePercent =
        residuePercentsOfDeactivatedItems / activeItems.length;
    for (var item in activeItems) {
      item.percent += increasePercent;
    }
    return this;
  }

  initPlanFromDB(Map<String, double> plan) {
    for (PlanItem item in planItems) {
      if (plan.containsKey(item.id)) item.value = plan[item.id]!;
    }
    return this;
  }
}

testPlanClass() {
  final data = PlanInputData(
    age: 26,
    partnerState: 'work',
    monthIncome: 6500,
    numberOfChildren: 1,
    childrenState: 'nursery',
    schoolState: null,
  );
  Plan.plan.setPlanInputData = data;
  Plan.plan.createBasePlan();
  Plan.plan.setPlanMode = PlanMode.aethetics;
  Plan.plan.getItem('cheeseDairy')!.active = true;
  Plan.plan.applyPreferences();
  Plan.plan.applyMode();
  Plan.plan.turnPercentsToValues();
  final res = Plan.plan.planItems
      .map(
        (e) => {e.id: e.value},
      )
      .toList();
  // sum of values should be equal to month income
  double sum = 0;
  for (var item in res) {
    sum += item.values.first;
  }
  print(sum);
}

class PlanItem {
  final String id;
  final String arabicName;
  final String englishName;
  final IconData icon;
  double percent = 0;
  double value = 0;
  // used in checklist
  bool active = true;
  bool appear = true;
  PlanCategories category;

  PlanItem({
    required this.id,
    required this.category,
    required this.arabicName,
    required this.englishName,
    required this.icon,
  });
}

abstract class PlanCategory {
  PlanCategories get id;
  String get arabicName;
  String get englishName;
  IconData get icon;
  List<PlanItem> get items;

  void appearItems() {
    for (PlanItem item in items) {
      item.active = true;
      item.appear = true;
    }
  }

  void disappearItems() {
    for (PlanItem item in items) {
      item.active = false;
      item.appear = false;
    }
  }

  int get numberOfActiveItems {
    int count = 0;
    for (PlanItem item in items) {
      if (item.active) count++;
    }
    return count;
  }

  const PlanCategory();
}

class NutrationCategory extends PlanCategory {
  @override
  final id = PlanCategories.nutration;
  @override
  final arabicName = "التغذية";
  @override
  final englishName = "Nutration";
  @override
  final icon = FontAwesomeIcons.utensils;

  late PlanItem cheeseDairy = PlanItem(
      category: id,
      arabicName: 'الأجبان والألبان',
      englishName: 'Cheese and Dairy',
      id: 'cheeseDairy',
      icon: FontAwesomeIcons.cheese);
  late PlanItem meat = PlanItem(
      category: id,
      arabicName: 'اللحوم',
      englishName: 'Meet',
      id: 'meat',
      icon: FontAwesomeIcons.drumstickBite);
  late PlanItem vegetablesAndFruits = PlanItem(
      category: id,
      arabicName: 'الخضار والفواكه',
      englishName: 'Vegetables and Fruits',
      id: 'vegetablesAndFruits',
      icon: FontAwesomeIcons.carrot);
  late PlanItem commodities = PlanItem(
      category: id,
      arabicName: 'السلع الأساسية',
      englishName: 'Commodities',
      id: 'commodities',
      icon: FontAwesomeIcons.breadSlice);
  List<PlanItem> get items => [
        cheeseDairy,
        meat,
        vegetablesAndFruits,
        commodities,
      ];
  NutrationCategory();
}

class SavingCategory extends PlanCategory {
  @override
  final id = PlanCategories.saving;
  @override
  final arabicName = "التوفير";
  @override
  final englishName = "Saving";
  @override
  final icon = FontAwesomeIcons.piggyBank;

  late PlanItem saving = PlanItem(
      category: id,
      arabicName: 'التوفير',
      englishName: 'Saving',
      id: 'saving',
      icon: FontAwesomeIcons.piggyBank);

  List<PlanItem> get items => [
        saving,
      ];
  SavingCategory();
}

class EducationChildrenCategory extends PlanCategory {
  @override
  final id = PlanCategories.educationChildren;
  @override
  final arabicName = "التعليم و الاطفال";
  @override
  final englishName = "Education & Children";
  @override
  final icon = FontAwesomeIcons.child;

  late PlanItem education = PlanItem(
      category: id,
      arabicName: 'التعليم',
      englishName: 'Education',
      id: 'education',
      icon: FontAwesomeIcons.book);
  late PlanItem diapers = PlanItem(
      category: id,
      arabicName: 'حفاظات اطفال',
      englishName: 'Diapers',
      id: 'diapers',
      icon: FontAwesomeIcons.babyCarriage);
  late PlanItem poketMoney = PlanItem(
      category: id,
      arabicName: 'مصروف',
      englishName: 'Poket Money',
      id: 'poketMoney',
      icon: FontAwesomeIcons.moneyBill1);

  List<PlanItem> get items => [
        education,
        diapers,
        poketMoney,
      ];

  EducationChildrenCategory();
}

class AetheticsCategory extends PlanCategory {
  @override
  final id = PlanCategories.aethetics;
  @override
  final arabicName = "الجمال";
  @override
  final englishName = "Aethetics";
  @override
  final icon = FontAwesomeIcons.spa;
  late PlanItem personalCare = PlanItem(
      category: id,
      arabicName: 'العناية الشخصية',
      englishName: 'Personal Care',
      id: 'personalCare',
      icon: FontAwesomeIcons.spa);
  late PlanItem clothes = PlanItem(
      category: id,
      arabicName: 'الملابس',
      englishName: 'Clothes',
      id: 'clothes',
      icon: FontAwesomeIcons.tshirt);

  List<PlanItem> get items => [
        personalCare,
        clothes,
      ];
  AetheticsCategory();
}

class OthersCategory extends PlanCategory {
  @override
  final id = PlanCategories.others;
  @override
  final arabicName = "أخرى";
  @override
  final englishName = "Others";
  @override
  final icon = FontAwesomeIcons.ellipsis;
  late PlanItem transportation = PlanItem(
      category: id,
      arabicName: 'المواصلات',
      englishName: 'Transportation',
      id: 'transportation',
      icon: FontAwesomeIcons.busSimple);
  late PlanItem entertainment = PlanItem(
      category: id,
      arabicName: 'الترفيه',
      englishName: 'Entertainment',
      id: 'entertainment',
      icon: FontAwesomeIcons.gamepad);
  late PlanItem phone = PlanItem(
      category: id,
      arabicName: 'الهاتف',
      englishName: 'Phone',
      id: 'phone',
      icon: FontAwesomeIcons.phoneAlt);
  late PlanItem invoices = PlanItem(
      category: id,
      arabicName: 'الفواتير',
      englishName: 'Invoices',
      id: 'invoices',
      icon: FontAwesomeIcons.fileInvoiceDollar);
  late PlanItem residence = PlanItem(
      category: id,
      arabicName: 'السكن',
      englishName: 'Residence',
      id: 'residence',
      icon: FontAwesomeIcons.home);
  late PlanItem detergent = PlanItem(
      category: id,
      arabicName: 'منظفات',
      englishName: 'Detergent',
      id: 'detergent',
      icon: FontAwesomeIcons.soap);
  late PlanItem charity = PlanItem(
      category: id,
      arabicName: 'الصدقات',
      englishName: 'Charity',
      id: 'charity',
      icon: FontAwesomeIcons.handHoldingHeart);
  late PlanItem health = PlanItem(
      category: id,
      arabicName: 'الصحة',
      englishName: 'Health',
      id: 'health',
      icon: FontAwesomeIcons.heartPulse);
  late PlanItem remainder = PlanItem(
      category: id,
      arabicName: 'باقي',
      englishName: 'Remainder',
      id: 'remainder',
      icon: FontAwesomeIcons.ellipsis);

  @override
  List<PlanItem> get items => [
        transportation,
        entertainment,
        phone,
        invoices,
        residence,
        detergent,
        charity,
        health,
        remainder,
      ];

  OthersCategory();
}

final Map<String, double> basePlanNoChild = {
  'cheeseDairy': 0.04,
  'commodities': 0.08,
  'vegetablesAndFruits': 0.08,
  'meat': 0.14,
  'clothes': 0.08,
  'residence': 0.04,
  'invoices': 0.08,
  'detergent': 0.08,
  'phone': 0.02,
  'education': 0,
  'poketMoney': 0,
  'diapers': 0,
  'entertainment': 0.05,
  'transportation': 0.04,
  'personalCare': 0.06,
  'health': 0.05,
  'saving': 0.08,
  'charity': 0.02,
  'remainder': 0.06,
};

final Map<String, double> basePlanNursery = {
  'cheeseDairy': 0.02,
  'commodities': 0.06,
  'vegetablesAndFruits': 0.08,
  'meat': 0.12,
  'clothes': 0.08,
  'residence': 0.05,
  'invoices': 0.08,
  'detergent': 0.02,
  'phone': 0.02,
  'education': .06,
  'poketMoney': 0,
  'diapers': 0.06,
  'entertainment': 0.05,
  'transportation': 0.04,
  'personalCare': 0.06,
  'health': 0.04,
  'saving': 0.08,
  'charity': 0.02,
  'remainder': 0.06,
};

final Map<String, double> basePlanSchool = {
  'cheeseDairy': 0.03,
  'commodities': 0.07,
  'vegetablesAndFruits': 0.08,
  'meat': 0.14,
  'clothes': 0.06,
  'residence': 0.02,
  'invoices': 0.08,
  'detergent': 0.02,
  'phone': 0.02,
  'education': 0.19,
  'poketMoney': 0.02,
  'diapers': 0,
  'entertainment': 0.02,
  'transportation': 0.04,
  'personalCare': 0.04,
  'health': 0.08,
  'saving': 0.04,
  'charity': 0.02,
  'remainder': 0.03,
};
