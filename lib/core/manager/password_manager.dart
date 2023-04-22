import 'package:encrypt/encrypt.dart';

final key = Key.fromLength(32);
final iv = IV.fromLength(16);

final encrypter = Encrypter(AES(key));

String encryptPin(String value) {
  return encrypter.encrypt(value, iv: iv).base64;
}

String decryptPin(String value) {
  final newValue = Encrypted.from64(value);
  return encrypter.decrypt(newValue, iv: iv);
}