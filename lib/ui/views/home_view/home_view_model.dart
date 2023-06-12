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
  final _passwordService = locator<PasswordService>();
  final _categoryService = locator<CategoryService>();
  final log = Logger();
  bool searching = false;

  List<Category> get categories => _categoryService.categoryList;
  List<Password> get passwords => _passwordService.passwordList;

  List searchItems = [];

  bool isObscure = true;

  void showPassword(Password password) {
    final index = passwords.indexOf(password);
    final obscure = passwords[index].obscure;
    passwords[index].copyWith(obscure: !obscure);
    notifyListeners();
  }

  Future<void> searchPassword(String name) async {
    searchItems = passwords
        .where((element) => element.name.toLowerCase().contains(name))
        .toList();

    notifyListeners();
  }

  void deletePassword(Password password) {
    setBusy(true);
    _passwordService.deletePassword(password);
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
  List<ListenableServiceMixin> get listenableServices => [_categoryService,_passwordService];
}
