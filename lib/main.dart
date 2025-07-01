import 'package:expense_manager/provider/category_provider.dart';
import 'package:expense_manager/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/provider/expense_provider.dart';
import 'package:expense_manager/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TagProvider(localStorage)),
        ChangeNotifierProvider(create: (_) => CategoryProvider(localStorage)),
        ChangeNotifierProvider(create: (_) => ExpenseProvider(localStorage)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      home: HomeScreen(),
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.deepPurple,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
