import 'package:passify/app/app.logger.dart';
import 'package:passify/core/dao/category_dao.dart';
import 'package:passify/core/database/app_database.dart';
import 'package:stacked/stacked.dart';

import '../models/category/category.dart';

class CategoryService with ListenableServiceMixin {
  final logger = getLogger("CategoryService");
  CategoryService() {
    getAllCategories();
  }

  static Future<CategoryDao> database() async {
    final db = await $FloorAppDataBase.databaseBuilder("pass-save-db").build();
    return db.categoryDao;
  }

  final List<Category> _categoryList = [];
  List<Category> get categoryList => _categoryList;

  Future<void> addCategory(Category category) async {
    final db = await CategoryService.database();
    _categoryList.insert(0, category);
    await db.insertCategory(category);
    notifyListeners();
    logger.v(" added ${category.id} ${category.name} to db");
  }

  Future<void> getAllCategories() async {
    final db = await CategoryService.database();
    logger.v("getting all categories");
    final firstCategory = Category(id: "1", name: "All");
    final otherCategories = await db.getAllCategories();
    _categoryList.add(firstCategory);
    for (Category element in otherCategories) {
        _categoryList.add(element);
      }
    notifyListeners();
  }

  Future<void> deleteCategory(Category category) async {
    final db = await CategoryService.database();
    _categoryList.remove(category);
    await db.deleteCategory(category);
    notifyListeners();
    logger.v(" deleted ${category.id} ${category.name} from db");
  }
}
