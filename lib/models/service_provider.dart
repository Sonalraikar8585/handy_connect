// models/service_provider.dart
class ServiceProvider {
  int? id;
  String name;
  String service;
  String phone;
  String location;

  ServiceProvider({
    this.id,
    required this.name,
    required this.service,
    required this.phone,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'service': service,
      'phone': phone,
      'location': location,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  ServiceProvider.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        service = map['service'],
        phone = map['phone'],
        location = map['location'];
}
