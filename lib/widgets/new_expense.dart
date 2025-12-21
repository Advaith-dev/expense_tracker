import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense exp) addExpense;
  const NewExpense({super.key, required this.addExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _displayDate;
  String _categorySelected = "food";

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime first = DateTime(now.year - 1, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: first,
      initialDate: now,
      lastDate: now,
    );
    setState(() {
      _displayDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    final bool isAmountValid = (enteredAmount == null || enteredAmount <= 0)
        ? false
        : true;
    if (_titleController.text.trim().isEmpty ||
        isAmountValid == false ||
        _displayDate == null) {
      //error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please make sure all the data was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }
    Expense exp = Expense(
      title: _titleController.text,
      amount: double.tryParse(_amountController.text)!,
      date: _displayDate!,
      category: Category.values.byName(_categorySelected),
    );
    widget.addExpense(exp);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: "₹ ",
                  ),
                  controller: _amountController,
                  inputFormatters: [DecimalTextInputFormatter()],
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _displayDate == null
                          ? "No Date Selected"
                          : formatter.format(_displayDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              DropdownButton(
                value: _categorySelected,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category.name,
                        child: Text(category.name.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _categorySelected = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
              const SizedBox(width: 18),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regExp = RegExp(r'^\d*\.?\d');

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
