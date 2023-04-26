import 'package:isar/isar.dart';

import '../category/category.dart';

part 'password.g.dart';

@Collection()
class Password {
  Id id = Isar.autoIncrement;
  @Index(caseSensitive: false)
  late String name;
  late String email;
  late String pin;
  late bool obscure = true;
  @Index(composite: [CompositeIndex('name')])
  final category = IsarLink<Categories>();
  @Index()
  late DateTime createdTime;
}
