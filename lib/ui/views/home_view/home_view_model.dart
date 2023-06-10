import 'dart:collection';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/category_service.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackBarService = locator<SnackbarService>();
  final _passwordService = PasswordService();
  final _categoryService = locator<CategoryService>();
  final log = Logger();
  bool searching = false;

  List<Password> _password = [];
  HomeViewModel() {
    readPassword();
  }

  List<Categories> get categories => _categoryService.categoryList;

  List searchItems = [];

  bool isObscure = true;

  int get count => _password.length;

  UnmodifiableListView<Password> get passwords =>
      UnmodifiableListView(_password);


  void addCategory(Categories categories) {
    _passwordService.saveCategory(categories);
  }

  void showPassword(Password password) {
    final index = _password.indexOf(password);
    final obscure = _password[index].obscure;

    _password[index].obscure = !obscure;
    notifyListeners();
  }

  

  Future<void> searchPassword(String name) async {
       searchItems = _password.where((element) => element.name.toLowerCase().contains(name)).toList();

    notifyListeners();
  }

  Future<void> readPassword() async {
    if (!searching) {
      _password = await _passwordService.getAllPasswords();
    }

    notifyListeners();
  }

  void deletePassword(int id) {
    setBusy(true);
    _passwordService.deletePassword(id);
    setBusy(false);
  }

  Future<bool> navigateToAddPassword({Password? password}) async {
    final response = await _navigationService.navigateTo(Routes.addNewPassword,
        arguments: AddNewPasswordArguments(password: password));
    if (response != null && response) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> copyData(String password) async {
    await Clipboard.setData(ClipboardData(text: password));
    _snackBarService.showSnackbar(message: "$password copied");
  }

   @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];
}
