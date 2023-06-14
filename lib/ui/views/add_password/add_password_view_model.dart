import 'package:flutter/material.dart';
import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.logger.dart';
import 'package:passify/app/app.router.dart';
import 'package:passify/core/manager/validation_manger.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/core/services/category_service.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:passify/ui/views/add_password/add_password.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';
import 'package:random_password_generator/random_password_generator.dart';

class AddPasswordViewModel extends FormViewModel {
  final _passwordService = locator<PasswordService>();
  final _navigationService = locator<NavigationService>();
  final _categoryService = locator<CategoryService>();
  final uuid = const Uuid();
  final passwordgenerator = RandomPasswordGenerator();

  AddPasswordViewModel(this.password);

  final Password? password;

  late FocusNode nameFocus = FocusNode();
  late FocusNode emailFocus = FocusNode();
  late FocusNode pinFocus = FocusNode();

  List<Category> get categories => _categoryService.categoryList;

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

  bool get disableButton =>
      !isFormValid || nameValue == null || pinValue == null || emailValue == "";

  void generatePassword() {
    checkBoxValue = !checkBoxValue;
    generatedPassword = passwordgenerator.randomPassword(
      letters: true,
      uppercase: true,
      numbers: true,
      specialChar: true,
      passwordLength: 10,
    );

    logger.v(generatedPassword);
    notifyListeners();
  }

  Future addPassword(Password password) async {
    await _passwordService.savePassword(password);
    notifyListeners();
    _navigationService.back(result: true);
  }

  void addNewPassword() async {
    if (!hasNameValidationMessage &&
        !hasEmailValidationMessage &&
        !hasPinValidationMessage) {
      password != null
          ? await addPassword(
              Password(
                  id: password?.id,
                  name: password!.name,
                  email: password!.email,
                  pin: password!.pin,
                  obscure: password!.obscure,
                  category: password!.category),
            )
          : await addPassword(
              Password(
                  id: uuid.v4(),
                  name: nameValue!,
                  email: emailValue!,
                  pin: pinValue!,
                  obscure: true,
                  category:dropdownValue != null? dropdownValue!.name !:""),
            );
    }
  }

  void navigateToCategoryView() {
    _navigationService.navigateTo(Routes.categoryView);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];

  @override
  void setFormStatus() {
    setNameValidationMessage(nameValidator(nameValue));
    setEmailValidationMessage(emailValidator(emailValue));
    setPinValidationMessage(passwordValidator(value: pinValue));
  }
}
