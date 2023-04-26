import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';

class HomeViewModel extends ChangeNotifier {
  final p = PasswordService();

  final List<Password> _password = [];
  HomeViewModel() {
    readPassword();
  }

  int get count => _password.length;

  UnmodifiableListView<Password> get passwords =>
      UnmodifiableListView(_password);

  void addCategory(Categories categories) {
    p.saveCategory(categories);
  }

  Future<bool> onWillPop(String test) async {
    final category = Categories()..name = test;
    if(test.isNotEmpty)  p.saveCategory(category);
    return true;
  }

  void addPassword(Password password) async {
    await p.savePassword(password);
    _password.add(password);
    notifyListeners();
  }

  Future<void> readPassword() async {
    _password.clear();

    notifyListeners();
  }

  void deletePassword(Password password) {
    _password.remove(password);
    notifyListeners();
  }

  void update(Password updatedPaswword) {
    final index = _password.indexOf(updatedPaswword);
    final oldPassword = _password[index];
    if (oldPassword.name != updatedPaswword.name ||
        oldPassword.email != updatedPaswword.email ||
        oldPassword.pin != updatedPaswword.pin ||
        oldPassword.obscure != updatedPaswword.obscure) {
      notifyListeners();
    }
  }
}
