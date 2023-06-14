import 'package:flutter/services.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PasswordSearchViewModel extends BaseViewModel {
  final _passwordService = locator<PasswordService>();
  final _navigationService = locator<NavigationService>();
  final _snackBarService = locator<SnackbarService>();

  List<Password> _passwordList = [];
  List<Password> get passwordList => _passwordList;

  void getPasswordList(String query) {
    _passwordList = _passwordService.passwordList;
    onSearch(query);
  }

  void onSearch(String query) {
    if (_passwordList.isNotEmpty) {
      _passwordList = _passwordList
          .where((password) => password.name.toLowerCase().contains(query))
          .toList();
    } else {
      getPasswordList(query);
    }
  }

  Future<void> copyData(String password) async {
    await Clipboard.setData(ClipboardData(text: password));
    _snackBarService.showSnackbar(message: "$password copied");
  }

  void showPassword(Password pass) {
    final index = _passwordList.indexOf(pass);
    final obscure = _passwordList[index].obscure;
    _passwordList[index].obscure = !obscure;

    notifyListeners();
  }

  void goToAddPasswordView(Password password) {
    _navigationService.navigateTo(
      Routes.addNewPassword,
      arguments: AddNewPasswordArguments(password: password),
    );
  }
}
