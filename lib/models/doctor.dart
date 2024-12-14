// models/doctor.dart
class Doctor {
  final String id;
  final String name;
  final String specialization;

  Doctor({required this.id, required this.name, required this.specialization});

  factory Doctor.fromMap(Map<String, dynamic> data) {
    return Doctor(
      id: data['id'],
      name: data['name'],
      specialization: data['specialization'],
    );
  }
}

// models/child.dart
class Child {
  final String id;
  final String name;
  final int age;

  Child({required this.id, required this.name, required this.age});

  factory Child.fromMap(Map<String, dynamic> data) {
    return Child(
      id: data['id'],
      name: data['name'],
      age: data['age'],
    );
  }
}
