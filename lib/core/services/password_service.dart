import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:path_provider/path_provider.dart';

class PasswordService {
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
    isar.writeTxnSync<int>(() => isar.categories.putSync(categories));
  }


  Stream<List<Password>> listenToPasswords() async* {
    logger.v("listening to all passwords");
    final isar = await db;
    yield* isar.passwords.where().watch(fireImmediately: true);
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
