import 'package:passify/app/app.logger.dart';
import 'package:passify/core/dao/password_dao.dart';
import 'package:passify/core/database/app_database.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:stacked/stacked.dart';

class PasswordService with ListenableServiceMixin {
  static Future<PasswordDao> database() async {
    final db = await $FloorAppDataBase.databaseBuilder("pass-save-db").build();
    return db.passwordDao;
  }

  final logger = getLogger("PasswordService");
  PasswordService() {
   getAllPasswords();
  }

  List<Password> _passwordList = [];
  List<Password> get passwordList => _passwordList;

  Future<void> savePassword(Password password) async {
    _passwordList.insert(0, password);
    final db = await PasswordService.database();
    await db.insertPassword(password);
    notifyListeners();
    logger.v(
        " added ${password.id} ${password.name} ${password.email} ${password.pin}to db");
  }

  Future<void> updatePassword(Password password) async {
  //  _passwordList.insert(0, password);
    final db = await PasswordService.database();
    await db.updatePassword(password);
    notifyListeners();
    logger.v(
        " updating ${password.id} ${password.name} ${password.email} ${password.pin}to db");
  }

  Future<void> getAllPasswords() async {
    logger.v("getting all categories");
    final db = await PasswordService.database();
    _passwordList = await db.getAllPasswords();
    notifyListeners();
  }

  Future<Password?> getOnePassword(String id) async {
    final db = await PasswordService.database();
    return await db.getPasswordById(id);
  }

  Future<void> getPasswordsByCategory(String category) async {
    final db = await PasswordService.database();
    final passwords = await db.getPasswordByCategory(category);
    logger.v(passwords);
    _passwordList = passwords;
    notifyListeners();
  }

  Future<void> deletePassword(Password password) async {
    final db = await PasswordService.database();
    _passwordList.remove(password);
    db.deletePassoword(password);
    notifyListeners();
    logger.v(" deleted ${password.id} ${password.name} from db");
  }
}
