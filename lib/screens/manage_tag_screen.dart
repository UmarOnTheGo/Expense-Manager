import 'package:expense_manager/provider/expense_provider.dart';
import 'package:expense_manager/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageTagScreen extends StatelessWidget {
  const ManageTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Categories')),
      body: Consumer<TagProvider>(
        builder: (context, tagProvider, child) {
          final tags = tagProvider.tag;
          if (tags.isEmpty) {
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
                  child: Text('Deleting a TAG also deletes its expenses'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    return Card(
                      child: ListTile(
                        title: Text(tag.tagName),
                        trailing: GestureDetector(
                          onTap: () {
                            tagProvider.removetagbyName(tag.tagName);
                            Provider.of<ExpenseProvider>(
                              context,
                              listen: false,
                            ).removeExpensewithTag(tag.tagName);
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
