import 'package:grade_calculator/student_validator.dart';

class Student {
  final String _name;
  final int _id;
  final int _age;
  final String _gender;
  final String _major;
  String _password;
  final String _email;

  Student(this._name, this._id, this._age, this._gender, this._major,
      this._password, this._email) {
    StudentValidator.validate(_name, _age, _gender, _password, _email);
  }

  // Factory constructor to create Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['name'],
      json['id'],
      json['age'],
      json['gender'],
      json['major'],
      json['password'],
      json['email'],
    );
  }

  // Method to convert Student to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'id': _id,
      'age': _age,
      'gender': _gender,
      'major': _major,
      'password': _password,
      'email': _email,
    };
  }

  // Getters for public access
  String get name => _name;
  int get id => _id;
  int get age => _age;
  String get gender => _gender;
  String get major => _major;
  String get email => _email;

  bool validatePassword(String password) {
    return _password == password;
  }

  void resetPassword(String password) {
    _password = password;
    print('Password has been reset successfully for $_name');
  }

  @override
  String toString() {
    return 'Student{id: $_id, name: $_name, age: $_age, gender: $_gender, major: $_major, email: $_email}';
  }
}
