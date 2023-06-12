import 'package:passify/app/app.locator.dart';
import 'package:passify/core/services/category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/category/category.dart';

class CategoryViewModel extends BaseViewModel {
  final _categoryService = locator<CategoryService>();
  final _snackbarService = locator<SnackbarService>();

  List<Category> get categories => _categoryService.categoryList;

  var uuid = const Uuid();

  Future<bool> onWillPop(String test) async {
    final category = Category(id: uuid.v4(), name: test);
    if (test.isNotEmpty) _categoryService.addCategory(category);
    return true;
  }

  Future<void> deleteCategory(Category categories) async {
    await _categoryService.deleteCategory(categories);

    _snackbarService.showSnackbar(message: "category deleted");

    notifyListeners();
  }
}
