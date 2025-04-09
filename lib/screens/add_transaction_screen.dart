import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../services/database_helper.dart';
import '../services/session_manager.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> allCategories = [
    'Salary', 'Freelance', 'Investments', // income
    'Food', 'Rent', 'Entertainment', 'Transport', // expenses
  ];

  String _category = 'Food';
  String _type = 'Expense';

  final userId = SessionManager().currentUser!.id;
  void _saveTransaction() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      await DatabaseHelper.instance.insertTransaction({
        'title': _titleController.text,
        'amount': double.parse(_amountController.text),
        'category': _category,
        'type': _type,
        'date': _selectedDate.toIso8601String(),
        'userId': userId,
      });
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: FormBuilderValidators.required(),
              ),
              // TextField(
              //   controller: _titleController,
              //   decoration: InputDecoration(labelText: 'Title'),
              // ),
              FormBuilderTextField(
                name: 'amount',
                controller: _amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              // TextField(
              //   controller: _amountController,
              //   decoration: InputDecoration(labelText: 'Amount'),
              //   keyboardType: TextInputType.number,
              // ),
              FormBuilderDropdown(
                name: 'category',
                decoration: InputDecoration(labelText: 'Category'),
                items:
                    allCategories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newVal) => setState(() => _category = newVal!),
                validator: FormBuilderValidators.required(),
              ),
              // DropdownButton<String>(
              //   value: _category,
              //   items:
              //       allCategories.map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //   onChanged: (newVal) => setState(() => _category = newVal!),
              // ),
              FormBuilderDropdown(
                name: 'type',
                items: 
                  ['Income', 'Expense'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newVal) => setState(() => _type = newVal!),
                validator: FormBuilderValidators.required(),
                decoration: InputDecoration(labelText: 'Txn Type'),
              ),
              // DropdownButton<String>(
              //   value: _type,
              //   items:
              //       ['Income', 'Expense'].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //   onChanged: (newVal) => setState(() => _type = newVal!),
              // ),
              SizedBox(height: 20),
              FormBuilderDateTimePicker(
                name: 'date',
                initialValue: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                decoration: InputDecoration(
                  labelText: "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedDate = val);
                  }
                },
                validator: FormBuilderValidators.required(),
              ),
              // TextButton(
              //   onPressed: () async {
              //     DateTime? picked = await showDatePicker(
              //       context: context,
              //       initialDate: _selectedDate,
              //       firstDate: DateTime(2000),
              //       lastDate: DateTime(2100),
              //     );
              //     if (picked != null) {
              //       setState(() => _selectedDate = picked);
              //     }
              //   },
              //   child: Text(
              //     "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveTransaction, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}