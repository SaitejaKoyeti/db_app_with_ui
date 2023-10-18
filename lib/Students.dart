
class Students {
  late int id;
  late String name;
  late int age;
  late int marks;

  Students(
      {required this.id,
        required this.name,
        required this.age,
        required this.marks});
  Students.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        age = result["age"],
        marks = result["marks"];

  Map<String, Object> toMap() {
    return {'id': id, 'name': name, 'age': age, 'marks': marks};
  }
}