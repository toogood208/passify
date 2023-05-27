import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.logger.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddPasswordViewModel extends BaseViewModel {
  final _passwordService = locator<PasswordService>();
  final _navigationService = locator<NavigationService>();

  AddPasswordViewModel(){
    getCategory();
  }

  late FocusNode nameFocus = FocusNode();
  late FocusNode emailFocus = FocusNode();
  late FocusNode pinFocus = FocusNode();

  List<Categories> _category = [];

  final logger = getLogger("AddPasswordViewModel");
  Categories? dropdownValue;
  bool checkBoxValue = false;

  String generatedPassword = "";

  UnmodifiableListView<Categories> get categories =>
      UnmodifiableListView(_category);


  void changeCategory(Categories? newValue) {
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
    navigatoHomeView();
  }

  void update({
    required int id,
    required String name,
    required String email,
    required String pin,
    required bool obscure,
    required Categories? category,
  }) async {
    final pass = await _passwordService.getOnePassword(id);
    pass!
      ..name = name
      ..email = email
      ..pin = pin
      ..obscure = obscure
      ..category.value = category
      ..createdTime = DateTime.now();
    addPassword(pass);
  }

  Future<void> getCategory() async {
    _category = await _passwordService.getAllCategories();
    notifyListeners();
  }

  void navigateToCategoryView(){
    _navigationService.navigateTo(Routes.categoryView);
  }
  void navigatoHomeView(){
    _navigationService.clearStackAndShow(Routes.homePage);
  }
}
