import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';

class HomeViewModel extends ChangeNotifier {
  final p = PasswordService();
  final log = Logger();
  String generatedPassword = "";
  bool checkBoxValue = false;

  final List<Password> _password = [];
  List<Categories> _category = [];
  HomeViewModel() {
    readPassword();
    getCategory();
  }

  bool isObscure = true;

  int get count => _password.length;
  Categories? dropdownValue;

  UnmodifiableListView<Password> get passwords =>
      UnmodifiableListView(_password);

  UnmodifiableListView<Categories> get categories =>
      UnmodifiableListView(_category);

  void addCategory(Categories categories) {
    p.saveCategory(categories);
  }

  void togglePassword() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> getCategory() async {
    _category = await p.getAllCategories();
    notifyListeners();
  }

  void changeCategory(Categories? newValue) {
    dropdownValue = null;
    dropdownValue = newValue;
    notifyListeners();
  }

  Future<bool> onWillPop(String test) async {
    final category = Categories()..name = test;
    if (test.isNotEmpty) p.saveCategory(category);
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

  void generatePassword() {
    checkBoxValue = !checkBoxValue;
    String lowercase = "abcdefghijkmnopqwxyz";
    String uppercase = "ABCDEFGHIJKLMNOPQWxYZ";
    String number = "0123456789";
    String symbols = "!@#\$%^&*?";

    String strongPassword = "$lowercase$uppercase$number$symbols";
    String password = List.generate(10, (index) {
      int randomIndex = Random.secure().nextInt(strongPassword.length);
      return strongPassword[randomIndex];
    }).join("");

    generatedPassword = password;

    log.v(generatedPassword);
    notifyListeners();
  }
}
