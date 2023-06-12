import 'package:floor/floor.dart';
import 'package:passify/core/models/category/category.dart';

@dao
abstract class CategoryDao {
  @Query("SELECT * FROM category")
  Future<List<Category>> getAllCategories();

  @Query("SELECT * FROM category")
  Stream<List<Category>> watchAllCategories();

  @Query("SELECT * FROM category WHERE id = :id")
  Future<Category?> getCategoryById(int id);

  @insert
  Future<void> insertCategory(Category category);

  @delete
  Future<void> deleteCategory(Category category);

  @update
  Future<void> updateCategory(Category category);
}
