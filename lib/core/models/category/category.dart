import 'package:floor/floor.dart';

@Entity(tableName: "category")
class Category {
  @PrimaryKey()
  final String? id;
  final String? name;

  Category({this.id, this.name});

  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
