import 'package:passify/core/dao/category_dao.dart';
import 'package:passify/core/dao/password_dao.dart';
import 'package:passify/core/database/app_database.dart';

class DatabaseService {
  Future<AppDataBase> database() async {
    return await $FloorAppDataBase.databaseBuilder("pass-save-db").build();
  }

  Future<PasswordDao> passwordDao() async {
    final db = await database();
    return db.passwordDao;
  }

  Future<CategoryDao> categoryDao() async {
    final db = await database();
    return db.categoryDao;
  }

}
