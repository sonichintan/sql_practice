import 'Helper.dart';

class Student {
  int id;
  String name;
  int age;

  Student(this.id, this.name, this.age);

  Student.fromMap(Map<String, dynamic> map) {

    id = map["id"];
    name = map["name"];
    age = map["age"];
  }

  Map<String, dynamic> toMap() {
    return {
      Helper.colId: id,
      Helper.colName: name,
      Helper.colAge: age,
    };
  }
}
