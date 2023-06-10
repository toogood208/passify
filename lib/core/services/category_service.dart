import 'package:isar/isar.dart';
import 'package:passify/app/app.logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import '../models/category/category.dart';
import '../models/password/password.dart';

class CategoryService with ListenableServiceMixin {
  final logger = getLogger("PasswordRService");
  CategoryService() {
    getAllCategories();
  }

  List<Categories> _categoryList = [];
  List<Categories> get categoryList => _categoryList;

  Future<void> addCategory(Categories categories) async {
    final isar = await openDB();
    _categoryList.insert(0, categories);
    await isar.writeTxn(() async {
      await isar.categories.putAll(_categoryList);
    });
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    logger.v("getting all categories");
    final isar = await openDB();
    _categoryList = await isar.categories.where().findAll();
    notifyListeners();
  }

   Future<void> deleteCategory(Categories categories) async{
     final isar = await openDB();
    _categoryList.remove(categories);
     await isar.writeTxn(() async {
      await isar.categories.delete(categories.id);
    });
    notifyListeners();
  }


  Future<Isar> openDB() async {
    logger.v("initializing db");
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PasswordSchema, CategoriesSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
}
