import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final p = PasswordService();
  final log = Logger();
  String generatedPassword = "";
  bool checkBoxValue = false;

  List<Password> _password = [];
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

  void showPassword(Password password) {
    final index = _password.indexOf(password);
    final obscure = _password[index].obscure;

    _password[index].obscure = !obscure;
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
    _password = await p.getAllPasswords();

    notifyListeners();
  }

  void deletePassword(Password password) {
    _password.remove(password);
    notifyListeners();
  }

  void update(
      {required int id,
      required String name,
      required String email,
      required String pin,
      required bool obscure,
      required Categories? category,}) async {
    final pass = await p.getOnePassword(id);
    pass!
      ..name = name
      ..email = email
      ..pin = pin
      ..obscure = obscure
      ..category.value = category
      ..createdTime = DateTime.now();
    addPassword(pass);
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

  late FocusNode nameFocus = FocusNode();
  late FocusNode emailFocus = FocusNode();
  late FocusNode pinFocus = FocusNode();

  void requestNameFocus(context) {
      FocusScope.of(context).requestFocus(nameFocus);
      notifyListeners();

  }

  void requestEmailFocus(context) {
    FocusScope.of(context).requestFocus(emailFocus);

  }

  void requestPinFocus(context) {
    FocusScope.of(context).requestFocus(pinFocus);

  }
}
