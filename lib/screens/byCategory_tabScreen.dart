import 'package:expense_manager/model/category_model.dart';
import 'package:expense_manager/model/expense_model.dart';
import 'package:expense_manager/provider/category_provider.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ByCategoryTab extends StatelessWidget {
  const ByCategoryTab({super.key});

  int generateTotalByTag(List<Expense> expenses, Category cat) {
    return expenses
        .where((e) => e.category == cat.catName)
        .fold(0, (sum, e) => sum + e.amount.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ExpenseProvider, CategoryProvider>(
        builder: (context, expenseProvider, categoryProvider, child) {
          final categorys = categoryProvider.cat;
          final expenses = expenseProvider.expense;

          if (categorys.isEmpty) {
            return Center(
              child: Text(
                'No expenses yet.\nClick + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: categorys.length,
              itemBuilder: (context, index) {
                final cat = categorys[index];
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(
                      Icons.category,
                      color: Colors.deepPurpleAccent,
                    ),
                    title: Center(
                      child: Text(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),

                        'Tag: ${cat.catName}       -      Total:\$${generateTotalByTag(expenses, cat)}',
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
