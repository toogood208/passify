import 'dart:collection';
import 'package:logger/logger.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final p = PasswordService();
  final log = Logger();

  List<Password> _password = [];
  List<Categories> _category = [];
  HomeViewModel() {
    readPassword();
    getCategory();
  }

  bool isObscure = true;

  int get count => _password.length;

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



  Future<void> readPassword() async {
    _password = await p.getAllPasswords();

    notifyListeners();
  }

  void deletePassword(Password password) {
    _password.remove(password);
    notifyListeners();
  }

  void navigateToAddPassword({Password? password}) {
    _navigationService.navigateTo(Routes.addNewPassword,
        arguments: AddNewPasswordArguments(password: password));
  }
}
