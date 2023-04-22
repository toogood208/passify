import 'package:passify/core/manager/password_manager.dart';

class Password {
  Password({
    required this.pin,
    this.name = '',
    this.obscure = true,
    this.email = '',
  });

  final String pin;
  final String name;
  final String email;
  bool obscure;

  factory Password.fromJson(Map<String, dynamic> json) => Password(
        pin: decryptPin(json["pin"]),
        name: json["name"],
        obscure: json["obscure"] ?? true,
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "pin": encryptPin(pin),
        "name": name,
        "obscure": obscure,
        "email": email,
      };

  Password copyWith({String? pin, String? name, bool? obscure, String? email}) {
    return Password(
        pin: pin ?? this.pin,
        name: name ?? this.name,
        obscure: obscure ?? this.obscure,
        email: email ?? this.email);
  }

  @override
  String toString() => "${Password(pin: pin,name:name,email:email,obscure:obscure)}";
}
