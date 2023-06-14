import 'package:floor/floor.dart';

@Entity(tableName: 'password',)
class Password {
  @PrimaryKey()
  final String? id;
  final String name;
  final String email;
  final String pin;
  bool obscure;
  @ColumnInfo(name: 'category')
  final String category;
  Password(
      {this.id,
      required this.name,
      required this.email,
      required this.pin,
      required this.obscure,
      required this.category,});

  Password copyWith({
    String? id,
    String? name,
    String? email,
    String? pin,
    bool? obscure,
    String? category,
  }) {
    return Password(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        pin: pin ?? this.pin,
        obscure: obscure ?? this.obscure,
        category: category ?? this.category,);
  }
}
