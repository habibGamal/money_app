import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanInputData {
  final String _gender;
  final int _age;
  final String _partnerState;
  final int _monthIncome;
  final int _numberOfChildren;
  final String? _childrenState;
  final String? _schoolState;

  PlanInputData({
    required String gender,
    required int age,
    required String partnerState,
    required int monthIncome,
    required int numberOfChildren,
    required String? childrenState,
    required String? schoolState,
  })  : _gender = gender,
        _age = age,
        _partnerState = partnerState,
        _monthIncome = monthIncome,
        _numberOfChildren = numberOfChildren,
        _childrenState = childrenState,
        _schoolState = schoolState;

  String get gender => _gender;
  int get age => _age;
  String get partnerState => _partnerState;
  int get monthIncome => _monthIncome;
  int get numberOfChildren => _numberOfChildren;
  String? get childrenState => _childrenState;
  String? get schoolState => _schoolState;
}

class Plan {
  final PlanInputData _planInputData;

  Plan({
    required PlanInputData planInputData,
  }) : _planInputData = planInputData;

  PlanInputData get planInputData => _planInputData;
  static final List<PlanCategory> categories = [
    NutrationCategory(),
    AetheticsCategory(),
    EducationChildrenCategory(),
    SavingCategory(),
    OthersCategory(),
  ];

  static List<PlanItem> get planItems {
    final List<PlanItem> items = [];
    for (PlanCategory category in categories) {
      items.addAll(category.items);
    }
    return items;
  }

  static PlanItem? getItem(String id) {
    for (PlanItem item in planItems) {
      if (item.id == id) return item;
    }
    return null;
  }

  static PlanCategory? getCategory(String id) {
    for (PlanCategory category in categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  Map<String, double>? determineBasePlanSchema() {
    final noChildren = planInputData._numberOfChildren == 0;
    if (noChildren) return basePlanNoChild;
    final nursery = planInputData._childrenState == 'nursery';
    if (nursery) return basePlanNursery;
    final school = planInputData._childrenState == 'school';
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
      item.value = item.percent * planInputData.monthIncome;
    }
  }

  Plan? createBasePlan() {
    final plan = determineBasePlanSchema();
    if (plan == null) return null;
    distributePercentsOverPlanItems(plan);
    return this;
  }

  applyPreferences() {
    // more logic will land here
    turnPercentsToValues();
    return this;
  }
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

  PlanItem({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.icon,
  });
}

abstract class PlanCategory {
  String get id;
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

  const PlanCategory();
}

class NutrationCategory extends PlanCategory {
  @override
  final id = "nutration";
  @override
  final arabicName = "التغذية";
  @override
  final englishName = "Nutration";
  @override
  final icon = FontAwesomeIcons.utensils;

  PlanItem cheeseDairy = PlanItem(
      arabicName: 'الأجبان والألبان',
      englishName: 'Cheese and Dairy',
      id: 'cheeseDairy',
      icon: FontAwesomeIcons.cheese);
  PlanItem meat = PlanItem(
      arabicName: 'اللحوم',
      englishName: 'Meet',
      id: 'meat',
      icon: FontAwesomeIcons.drumstickBite);
  PlanItem vegetablesAndFruits = PlanItem(
      arabicName: 'الخضار والفواكه',
      englishName: 'Vegetables and Fruits',
      id: 'vegetablesAndFruits',
      icon: FontAwesomeIcons.carrot);
  PlanItem commodities = PlanItem(
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
  final id = "saving";
  @override
  final arabicName = "التوفير";
  @override
  final englishName = "Saving";
  @override
  final icon = FontAwesomeIcons.piggyBank;

  PlanItem saving = PlanItem(
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
  final id = "educationChildren";
  @override
  final arabicName = "التعليم و الاطفال";
  @override
  final englishName = "Education & Children";
  @override
  final icon = FontAwesomeIcons.child;

  PlanItem education = PlanItem(
      arabicName: 'التعليم',
      englishName: 'Education',
      id: 'education',
      icon: FontAwesomeIcons.book);
  PlanItem diapers = PlanItem(
      arabicName: 'حفاظات اطفال',
      englishName: 'Diapers',
      id: 'diapers',
      icon: FontAwesomeIcons.babyCarriage);
  PlanItem poketMoney = PlanItem(
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
  final id = "aethetics";
  @override
  final arabicName = "الجمال";
  @override
  final englishName = "Aethetics";
  @override
  final icon = FontAwesomeIcons.spa;
  PlanItem personalCare = PlanItem(
      arabicName: 'العناية الشخصية',
      englishName: 'Personal Care',
      id: 'personalCare',
      icon: FontAwesomeIcons.spa);
  PlanItem clothes = PlanItem(
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
  final id = "others";
  @override
  final arabicName = "أخرى";
  @override
  final englishName = "Others";
  @override
  final icon = FontAwesomeIcons.ellipsis;
  PlanItem transportation = PlanItem(
      arabicName: 'المواصلات',
      englishName: 'Transportation',
      id: 'transportation',
      icon: FontAwesomeIcons.busSimple);
  PlanItem entertainment = PlanItem(
      arabicName: 'الترفيه',
      englishName: 'Entertainment',
      id: 'entertainment',
      icon: FontAwesomeIcons.gamepad);
  PlanItem phone = PlanItem(
      arabicName: 'الهاتف',
      englishName: 'Phone',
      id: 'phone',
      icon: FontAwesomeIcons.phoneAlt);
  PlanItem invoices = PlanItem(
      arabicName: 'الفواتير',
      englishName: 'Invoices',
      id: 'invoices',
      icon: FontAwesomeIcons.fileInvoiceDollar);
  PlanItem residence = PlanItem(
      arabicName: 'السكن',
      englishName: 'Residence',
      id: 'residence',
      icon: FontAwesomeIcons.home);
  PlanItem detergent = PlanItem(
      arabicName: 'منظفات',
      englishName: 'Detergent',
      id: 'detergent',
      icon: FontAwesomeIcons.soap);
  PlanItem charity = PlanItem(
      arabicName: 'الصدقات',
      englishName: 'Charity',
      id: 'charity',
      icon: FontAwesomeIcons.handHoldingHeart);
  PlanItem health = PlanItem(
      arabicName: 'الصحة',
      englishName: 'Health',
      id: 'health',
      icon: FontAwesomeIcons.heartPulse);
  PlanItem remainder = PlanItem(
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
