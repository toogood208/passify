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

  List<Password> get passwords => _passwordService.passwordList;
  List<Category> get categories => _categoryService.categoryList;

  int selectedTypeIndex = 0;
  int _selectedCategoryIndex = -1;

  bool isObscure = true;

  void showPassword(Password pass) {
    final index = passwords.indexOf(pass);
    final obscure = passwords[index].obscure;
    passwords[index].obscure = !obscure;

    notifyListeners();
  }

  List<Password> clickItems = [];

  Future<void> clickChip(String name) async {
    if (passwords.isNotEmpty) {
      clickItems = _selectedCategoryIndex > 0
          ? passwords
              .where((element) => element.category == name)
              .where(
                (password) => password.name.toLowerCase().contains(name),
              )
              .toList()
          : passwords;
    }
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

  void selectChips(int index) {
    _selectedCategoryIndex = index;
    selectedTypeIndex = index;
    final choice = categories[selectedTypeIndex].name;
    if (choice == "All") {
      _passwordService.getAllPasswords();
    }else{
       _passwordService.getPasswordsByCategory(choice!);

    }
   

    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_categoryService, _passwordService];
}
