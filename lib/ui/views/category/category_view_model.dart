import 'dart:collection';

import 'package:passify/app/app.locator.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/models/category/category.dart';

class CategoryViewModel extends BaseViewModel{
  final _passwordService = locator<PasswordService>();
  final _snackbarService = locator<SnackbarService>();

  CategoryViewModel(){
    _getCategory();
  }

  Future<bool> onWillPop(String test) async {
    final category = Categories()..name = test;
    if (test.isNotEmpty) _passwordService.saveCategory(category);
    return true;
  }

  List<Categories> _category = [];

  UnmodifiableListView<Categories> get categories =>
      UnmodifiableListView(_category);

  Future<void> _getCategory() async {
    _category = await _passwordService.getAllCategories();
    notifyListeners();
  }

  Future<void> deleteCategory(int id) async {
   final response= await _passwordService.deleteCategory(id);
   print(response);
   if(response){
     _snackbarService.showSnackbar(message: "category deleted");
   }
    notifyListeners();
  }
}