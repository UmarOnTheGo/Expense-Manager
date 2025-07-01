import 'dart:convert';

import 'package:expense_manager/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CategoryProvider extends ChangeNotifier {
  final LocalStorage storage;
  List<Category> _categorys = [];
  List<Category> get cat => _categorys;
  CategoryProvider(this.storage) {
    _loadcategorysFromStorage();
  }

  void _loadcategorysFromStorage() async {
    var storedcategorys = storage.getItem('category');
    if (storedcategorys != null) {
      final List<dynamic> decoded = jsonDecode(storedcategorys);
      _categorys = decoded.map((item) => Category.fromJson(item)).toList();
      notifyListeners();
    }
  }

  void saveToLocalStorage() {
    final data = jsonEncode(_categorys.map((e) => e.toJson()).toList());
    storage.setItem('category', data);
  }

  void addcategory(Category category) {
    bool alreadyExists = _categorys.any(
      (c) => c.catName.toLowerCase() == category.catName.toLowerCase(),
    );
    if (!alreadyExists) {
      _categorys.add(category);
      saveToLocalStorage();
      notifyListeners();
    }
  }

  void addOrUpdatecategory(Category category) {
    int index = _categorys.indexWhere((e) => e.id == category.id);
    if (index != -1) {
      _categorys[index] = category;
    }
    saveToLocalStorage();
    notifyListeners();
  }

  void removecategorybyId(String id) {
    _categorys.removeWhere((e) => e.id == id);
    saveToLocalStorage();
    notifyListeners();
  }

  void removecategorybyName(String name) {
    _categorys.removeWhere((e) => e.catName == name);
    saveToLocalStorage();
    notifyListeners();
  }
}
