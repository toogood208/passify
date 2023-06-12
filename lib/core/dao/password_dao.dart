import 'package:floor/floor.dart';
import 'package:passify/core/models/password/password.dart';

@dao
abstract class PasswordDao {
  @Query("SELECT * FROM password")
  Future<List<Password>> getAllPasswords();

  @Query("SELECT * FROM password")
  Stream<List<Password>> watchAllPasswords();

  @Query("SELECT * FROM password WHERE id = :id")
  Future<Password?> getPasswordById(int id);

  @insert
  Future<void> insertPassword(Password password);

  @delete
  Future<void> deletePassoword(Password password);

  @update
  Future<void> updatePassword(Password password);
}
