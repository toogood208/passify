import 'package:isar/isar.dart';

part 'category.g.dart';

@Collection()
class Categories {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;
}
