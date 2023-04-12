import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/model/model.dart';
import 'package:money_app/model_util/category.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/category.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/keyboard_dismiss.dart';
import 'package:intl/intl.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';
import '../widgets/bold_text.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final _formKey = GlobalKey<FormState>();
  int _selectedCategory = 1;
  String _amount = '';
  String _note = '';
  DateTime _date = DateTime.now();
  changeSelectedCategory(int index) {
    setState(() {
      _selectedCategory = index;
    });
  }

  onSave(bool mode) async {
    Record.withFields(
      mode,
      double.parse(_amount),
      _selectedCategory,
      _note,
      _date,
    ).save();
    final records = await Record().select().where('type = $mode').toList();
    updateRecords();
  }

  updateRecords() {
    Provider.of<AppState>(context, listen: false).refreshRecords();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final categoriesList = appState.currentMode == Mode.expense
        ? expenseCategories
        : incomeCategories;
    return Scaffold(
      appBar: AppBar(
        title: BoldText('Add record to ${appState.currentModeString}s'),
      ),
      body: KeyboardDismiss(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  SizedBox(
                    height: appState.currentMode == Mode.expense ? 200 : 100,
                    child: GridView(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 160,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        children: [
                          ...categoriesList
                              .map((category) => CategoryCard(
                                    category,
                                    selectedCategory: _selectedCategory,
                                    callback: changeSelectedCategory,
                                  ))
                              .toList(),
                        ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _amount = newValue;
                      }
                      print(newValue);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount of money',
                      labelStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryLight,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount of money that you spent';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) =>
                        {if (newValue != null) _note = newValue},
                    decoration: InputDecoration(
                      labelText: 'Note (optional)',
                      labelStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryLight,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // choose date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GrayText(
                            'Choosen Date : ${DateFormat('yyyy-MM-dd').format(_date).toString()}'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            setState(() {
                              if (date != null) _date = date;
                            });
                          },
                          child: const Text('Choose Date'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added successfully')),
                        );
                        _formKey.currentState!.save();
                        onSave(appState.currentRecordType);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
