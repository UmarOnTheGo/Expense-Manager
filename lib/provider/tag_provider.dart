import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../model/tag_model.dart';

class TagProvider extends ChangeNotifier {
  final LocalStorage storage;
  List<Tag> _tags = [];
  List<Tag> get tag => _tags;
  TagProvider(this.storage) {
    _loadtagsFromStorage();
  }
  void _loadtagsFromStorage() async {
    var storedtags = storage.getItem('tag');
    if (storedtags != null) {
      final List<dynamic> decoded = jsonDecode(storedtags);
      _tags = decoded.map((item) => Tag.fromJson(item)).toList();
      notifyListeners();
    }
  }

  void saveToLocalStorage() {
    final data = jsonEncode(_tags.map((e) => e.toJson()).toList());
    storage.setItem('tag', data);
  }

  void addtag(Tag tag) {
    bool alreadyExists = _tags.any(
      (t) => t.tagName.toLowerCase() == tag.tagName.toLowerCase(),
    );
    if (!alreadyExists) {
      _tags.add(tag);
      saveToLocalStorage();
      notifyListeners();
    }
  }

  void addOrUpdatetag(Tag tag) {
    int index = _tags.indexWhere((e) => e.id == tag.id);
    if (index != -1) {
      _tags[index] = tag;
    }
    saveToLocalStorage();
    notifyListeners();
  }

  void removetagbyId(String id) {
    _tags.removeWhere((e) => e.id == id);
    saveToLocalStorage();
    notifyListeners();
  }

  void removetagbyName(String name) {
    _tags.removeWhere((e) => e.tagName == name);
    saveToLocalStorage();
    notifyListeners();
  }
}
