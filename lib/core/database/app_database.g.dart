// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PasswordDao? _passwordDaoInstance;

  CategoryDao? _categoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `password` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `pin` TEXT NOT NULL, `obscure` INTEGER NOT NULL, `category` TEXT NOT NULL, FOREIGN KEY (`category`) REFERENCES `Category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` TEXT, `name` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PasswordDao get passwordDao {
    return _passwordDaoInstance ??= _$PasswordDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$PasswordDao extends PasswordDao {
  _$PasswordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _passwordInsertionAdapter = InsertionAdapter(
            database,
            'password',
            (Password item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pin': item.pin,
                  'obscure': item.obscure ? 1 : 0,
                  'category': item.category
                },
            changeListener),
        _passwordUpdateAdapter = UpdateAdapter(
            database,
            'password',
            ['id'],
            (Password item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pin': item.pin,
                  'obscure': item.obscure ? 1 : 0,
                  'category': item.category
                },
            changeListener),
        _passwordDeletionAdapter = DeletionAdapter(
            database,
            'password',
            ['id'],
            (Password item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'pin': item.pin,
                  'obscure': item.obscure ? 1 : 0,
                  'category': item.category
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Password> _passwordInsertionAdapter;

  final UpdateAdapter<Password> _passwordUpdateAdapter;

  final DeletionAdapter<Password> _passwordDeletionAdapter;

  @override
  Future<List<Password>> getAllPasswords() async {
    return _queryAdapter.queryList('SELECT * FROM password',
        mapper: (Map<String, Object?> row) => Password(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pin: row['pin'] as String,
            obscure: (row['obscure'] as int) != 0,
            category: row['category'] as String));
  }

  @override
  Stream<List<Password>> watchAllPasswords() {
    return _queryAdapter.queryListStream('SELECT * FROM password',
        mapper: (Map<String, Object?> row) => Password(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pin: row['pin'] as String,
            obscure: (row['obscure'] as int) != 0,
            category: row['category'] as String),
        queryableName: 'password',
        isView: false);
  }

  @override
  Future<Password?> getPasswordById(int id) async {
    return _queryAdapter.query('SELECT * FROM password WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Password(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            pin: row['pin'] as String,
            obscure: (row['obscure'] as int) != 0,
            category: row['category'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertPassword(Password password) async {
    await _passwordInsertionAdapter.insert(password, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePassword(Password password) async {
    await _passwordUpdateAdapter.update(password, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePassoword(Password password) async {
    await _passwordDeletionAdapter.delete(password);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'category',
            ['id'],
            (Category item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  @override
  Future<List<Category>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) =>
            Category(id: row['id'] as String?, name: row['name'] as String?));
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        mapper: (Map<String, Object?> row) =>
            Category(id: row['id'] as String?, name: row['name'] as String?),
        queryableName: 'category',
        isView: false);
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Category(id: row['id'] as String?, name: row['name'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _categoryUpdateAdapter.update(category, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategory(Category category) async {
    await _categoryDeletionAdapter.delete(category);
  }
}
