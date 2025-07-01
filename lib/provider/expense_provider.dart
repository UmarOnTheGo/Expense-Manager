import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:expense_manager/model/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  final LocalStorage storage;

  List<Expense> _expense = [];
  List<Expense> get expense {
    _expense.sort((a, b) => b.date.compareTo(a.date));
    return _expense;
  }

  ExpenseProvider(this.storage) {
    _loadExpensesFromStorage();
  }

  void _loadExpensesFromStorage() async {
    var storedExpenses = storage.getItem('expense');
    if (storedExpenses != null) {
      final List<dynamic> decoded = jsonDecode(storedExpenses);
      _expense = decoded.map((item) => Expense.fromJson(item)).toList();
      notifyListeners();
    }
  }

  void saveToLocalStorage() {
    final data = jsonEncode(_expense.map((e) => e.toJson()).toList());
    storage.setItem('expense', data);
  }

  void addExpense(Expense expense) {
    _expense.add(expense);
    saveToLocalStorage();
    notifyListeners();
  }

  void addOrUpdateExpense(Expense oldExpense, Expense newExpense) {
    int index = _expense.indexWhere((e) => e.id == oldExpense.id);
    if (index != -1) {
      _expense[index] = newExpense;
    }
    saveToLocalStorage();
    notifyListeners();
  }

  void removeExpense(String id) {
    _expense.removeWhere((e) => e.id == id);
    saveToLocalStorage();
    notifyListeners();
  }

  void removeExpensewithCategory(String id) {
    _expense.removeWhere((e) => e.category == id);
    saveToLocalStorage();
    notifyListeners();
  }

  void removeExpensewithTag(String id) {
    _expense.removeWhere((e) => e.tag == id);
    saveToLocalStorage();
    notifyListeners();
  }
}
