import 'package:expense_manager/screens/byCategory_tabScreen.dart';
import 'package:expense_manager/screens/byTag_tabScreen.dart';
import 'package:expense_manager/screens/manage_category_screen.dart';
import 'package:expense_manager/screens/manage_tag_screen.dart';
import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import 'byDate_tabScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // By Date, Tag, Category
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Center(
                  child: Text(
                    'Expense Manager',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ManageCategoryScreen()),
                  );
                },
                leading: Icon(Icons.edit),
                title: Text('Manage Category'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => ManageTagScreen()));
                },
                leading: Icon(Icons.edit),
                title: Text('Manage Tags'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Expense Manager'),
          bottom: TabBar(
            indicatorColor: Colors.purple,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelColor: Colors.deepPurpleAccent,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            labelColor: Colors.white,
            tabs: [
              Tab(child: Text('By Date')),
              Tab(child: Text('By Tab')),
              Tab(child: Text('By Category')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ByDateTab(),
            ByTagTab(), // You'll create this
            ByCategoryTab(), // You'll create this
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'fab-home',
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => AddExpenseScreen()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
