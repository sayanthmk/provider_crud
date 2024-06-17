class StudentModel {
  int? id;
  final String name;
  final String age;
  final String country;
  final String phone;
  final String selectimage;
  StudentModel(
      {required this.name,
      required this.age,
      required this.country,
      required this.phone,
      required this.selectimage,
      this.id});
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final country = map['country'] as String;
    final phone = map['phone'] as String;
    final selectimage = map['image'] as String;
    return StudentModel(
        id: id,
        name: name,
        age: age,
        country: country,
        phone: phone,
        selectimage: selectimage);
  }
}
