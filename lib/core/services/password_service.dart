import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

class PasswordService with ListenableServiceMixin {
  late Future<Isar> db;
  final logger = Logger();
  PasswordService() {
    db = openDB();
  }


  Future<void> savePassword(Password password) async {
    logger.v("adding $password to $db");
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.passwords.putSync(password));
  }

  Future<void> saveCategory(Categories categories) async {
    logger.v("adding $categories to $db");
    final isar = await db;
    isar.writeTxnSync<int>(()=> isar.categories.putSync(categories));
  }

  Stream<List<Password>> listenToPasswords() async* {
    logger.v("listening to all passwords");
    final isar = await db;
    yield* isar.passwords.where().watch(fireImmediately: true);
  }

  Stream<List<Categories>> listenToCategories() async* {
    logger.v("listening to all passwords");
    final isar = await db;
    yield* isar.categories.where().watch(fireImmediately: true);
  }

  Future<void> cleanDB() async {
    logger.v("cleared to all passwords in db");
    final isar = await db;
    isar.writeTxn(() => isar.clear());
  }

  Future<List<Password>> getAllPasswords() async {
    logger.v("getting all passwords");
    final isar = await db;
    return await isar.passwords.where().findAll();
  }

  Future<List<Password>> searchPasswords(String name) async {
    logger.v("getting all passwords");
    final isar = await db;
    return await isar.passwords.filter().nameContains(name).findAll();
  }

  Future<Password?> getOnePassword(int id) async {
    final isar = await db;
    return await isar.passwords.get(id);
  }

  Future<List<Categories>> getAllCategories() async {
    logger.v("getting all categories");
    final isar = await db;
    return await isar.categories.where().findAll();
  }

  Future<bool> deleteCategory(int id) async {
    final isar = await db;
    final response = isar.writeTxn(() => isar.categories.delete(id));

    return response;
  }

  Future<bool> deletePassword(int id) async {
    final isar = await db;
    final response = isar.writeTxn(() => isar.passwords.delete(id));

    return response;
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
