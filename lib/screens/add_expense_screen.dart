import 'package:expense_manager/model/category_model.dart';
import 'package:expense_manager/model/expense_model.dart';
import 'package:expense_manager/model/tag_model.dart';
import 'package:expense_manager/provider/category_provider.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'package:expense_manager/provider/tag_provider.dart';
import 'package:expense_manager/utils/widgets/dropTextfield_category_widget.dart';
import 'package:expense_manager/utils/widgets/dropTextfield_tag_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  DateTime? currentDate = DateTime.now();
  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(currentDate!);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final Expense? exp = widget.expense;
    if (exp != null) {
      _amountController.text = exp.amount.toString();
      _payeeController.text = exp.payee;
      _noteController.text = exp.note;
      _dateController.text = DateFormat('yyyy-MM-dd').format(exp.date);
      _tagController.text = exp.tag;
      _categoryController.text = exp.category;
      currentDate = exp.date;
    }
  }

  void saveExpense() {
    if (_amountController.text.isNotEmpty &&
        _payeeController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _noteController.text.isNotEmpty &&
        _tagController.text.isNotEmpty) {
      final Expense expense = Expense(
        payee: _payeeController.text.trim(),
        amount: double.parse(_amountController.text),
        note: _noteController.text.trim(),
        date: currentDate!,
        tag: _tagController.text.trim(),
        category: _categoryController.text.trim(),
      );
      final provider = Provider.of<ExpenseProvider>(context, listen: false);
      final bool isEmpty = widget.expense == null;
      if (!isEmpty) {
        provider.addOrUpdateExpense(widget.expense!, expense);
      } else {
        provider.addExpense(expense);
      }
      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).addcategory(Category(catName: _categoryController.text.trim()));
      Provider.of<TagProvider>(
        context,
        listen: false,
      ).addtag(Tag(tagName: _tagController.text.trim()));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple,
          content: Text('Some Fields are empty'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _payeeController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _categoryController.dispose();
    _tagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Expense')),
      body: Consumer2<TagProvider, CategoryProvider>(
        builder: (context, tagProvider, categoryProvider, child) {
          final tags = tagProvider.tag;
          final category = categoryProvider.cat;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  text: 'Amount',
                  controller: _amountController,
                  textInputType: TextInputType.number,
                ),
                CustomTextField(text: 'Payee', controller: _payeeController),
                CustomTextField(text: 'Note', controller: _noteController),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit_calendar_outlined),
                      labelText: 'Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    controller: _dateController,
                    onTap: () {
                      selectDate();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: DropTagWidget(
                    text: 'Tags',
                    options: tags,
                    controller: _tagController,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: DropCatWidegt(
                    text: 'Categories',
                    options: category,
                    controller: _categoryController,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 16, right: 40),
                  child: TextButton(
                    onPressed: () {
                      saveExpense();
                    },
                    child: Text(widget.expense == null ? 'Confirm' : 'Update'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
