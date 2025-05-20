// models/user.dart
class User {
  int? id;
  String name;
  String role;
  String phone;

  User({this.id, required this.name, required this.role, required this.phone});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'role': role,
      'phone': phone,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        role = map['role'],
        phone = map['phone'];
}
