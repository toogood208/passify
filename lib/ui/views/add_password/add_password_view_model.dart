import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.logger.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/category_service.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddPasswordViewModel extends ReactiveViewModel {
  final _passwordService = locator<PasswordService>();
  final _navigationService = locator<NavigationService>();
  final _categoryService = locator<CategoryService>();


  late FocusNode nameFocus = FocusNode();
  late FocusNode emailFocus = FocusNode();
  late FocusNode pinFocus = FocusNode();

 // List<Category> get categories => _categoryService.categoryList;
 List<Category> categories = [];

  final logger = getLogger("AddPasswordViewModel");
  Category? dropdownValue;
  bool checkBoxValue = false;

  String generatedPassword = "";


  void changeCategory(Category? newValue) {
    dropdownValue = null;
    dropdownValue = newValue;
    notifyListeners();
  }

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

    logger.v(generatedPassword);
    notifyListeners();
  }

  void addPassword(Password password) async {
    await _passwordService.savePassword(password);
    notifyListeners();
    _navigationService.back(result: true);
  }

  void update({
    required int id,
    required String name,
    required String email,
    required String pin,
    required bool obscure,
    required String? category,
  }) async {
    final pass = await _passwordService.getOnePassword(id);
    pass!.copyWith(
      name: name,
      email: email,
      pin: pin,
      obscure: obscure,
      category: category,
    );
    addPassword(pass);
  }

  void navigateToCategoryView() {
    _navigationService.navigateTo(Routes.categoryView);
  }


  @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];
}
