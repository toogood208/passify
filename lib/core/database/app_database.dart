import 'dart:async';

import 'package:floor/floor.dart';
import 'package:passify/core/dao/category_dao.dart';
import 'package:passify/core/dao/password_dao.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Password, Category])
abstract class AppDataBase extends FloorDatabase {
  PasswordDao get passwordDao;
  CategoryDao get categoryDao;
}
