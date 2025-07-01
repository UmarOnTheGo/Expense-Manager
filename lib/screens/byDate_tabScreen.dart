import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../provider/expense_provider.dart';
import 'add_expense_screen.dart';
import 'package:flutter/material.dart';

class ByDateTab extends StatelessWidget {
  const ByDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          final expenses = expenseProvider.expense;
          if (expenses.isEmpty) {
            return Center(
              child: Text(
                'No expenses yet.\nClick + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return Slidable(
                key: ValueKey(expense.id),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => Provider.of<ExpenseProvider>(
                        listen: false,
                        context,
                      ).removeExpense(expense.id),
                      backgroundColor: Colors.red,
                      icon: Icons.delete_forever,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (_) {
                        final index = expenses.indexWhere(
                          (e) => e.id == expense.id,
                        );
                        if (index != -1) {
                          final exp = expenses[index];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddExpenseScreen(expense: exp),
                            ),
                          );
                        }
                      },
                      backgroundColor: Colors.blueAccent,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.attach_money),
                      title: DefaultTextStyle.merge(
                        child: Text(
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          '${expense.payee} - \$${expense.amount.toStringAsFixed(2)}',
                        ),
                      ),
                      subtitle: Text(
                        '${DateFormat('yyyy-MM-dd').format(expense.date)} • Category: ${expense.category}',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
