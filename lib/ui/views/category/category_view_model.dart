
import 'package:passify/app/app.locator.dart';
import 'package:passify/core/services/category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/models/category/category.dart';

class CategoryViewModel extends BaseViewModel{
  final _categoryService = locator<CategoryService>();
  final _snackbarService = locator<SnackbarService>();

  List<Categories> get categories => _categoryService.categoryList;

  Future<bool> onWillPop(String test) async {
    final category = Categories()..name = test;
    if (test.isNotEmpty) _categoryService.addCategory(category);
    return true;
  }


  Future<void> deleteCategory(Categories categories) async {
    await _categoryService.deleteCategory(categories);

     _snackbarService.showSnackbar(message: "category deleted");
   
    notifyListeners();
  }
}