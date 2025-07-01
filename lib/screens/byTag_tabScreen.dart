import 'package:expense_manager/model/expense_model.dart';
import 'package:expense_manager/model/tag_model.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'package:expense_manager/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ByTagTab extends StatelessWidget {
  const ByTagTab({super.key});
  int generateTotalByTag(List<Expense> expenses, Tag tag) {
    return expenses
        .where((e) => e.tag == tag.tagName)
        .fold(0, (sum, e) => sum + e.amount.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ExpenseProvider, TagProvider>(
        builder: (context, expenseProvider, tagProvider, child) {
          final tags = tagProvider.tag;
          final expenses = expenseProvider.expense;

          if (tags.isEmpty) {
            return Center(
              child: Text(
                'No expenses yet.\nClick + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: tags.length,
              itemBuilder: (context, index) {
                final tag = tags[index];
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.sell, color: Colors.deepPurpleAccent),
                    title: Center(
                      child: Text(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),

                        'Tag: ${tag.tagName}       -      Total:\$${generateTotalByTag(expenses, tag)}',
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
