import 'package:expense_manager/provider/category_provider.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoryScreen extends StatelessWidget {
  const ManageCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Categories')),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          final categories = categoryProvider.cat;
          if (categories.isEmpty) {
            return Center(
              child: Text(
                'No expenses yet.\nClick + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            );
          }
          return Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.red.shade200,
                child: Center(
                  child: Text('Deleting a category also deletes its expenses'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Card(
                      child: ListTile(
                        title: Text(cat.catName),
                        trailing: GestureDetector(
                          onTap: () {
                            categoryProvider.removecategorybyName(cat.catName);
                            Provider.of<ExpenseProvider>(
                              context,
                              listen: false,
                            ).removeExpensewithCategory(cat.catName);
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
