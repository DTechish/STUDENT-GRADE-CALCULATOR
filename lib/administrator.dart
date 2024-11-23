import 'package:grade_calculator/student.dart';

// Creating Administrator class using the Singleton pattern
// A singleton class is a class in OOP that's restricted to a single instance.
class Administrator {
  // Singleton instance
  static final Administrator _instance = Administrator._internal(
    adminId: 'ADMIN001',
    username: 'admin',
    password: 'admin123',
    email: 'admin@school.com',
  );

  final String adminId;
  final String username;
  String password;
  String email;
  bool isLoggedIn = false;

  // Private constructor
  Administrator._internal({
    required this.adminId,
    required this.username,
    required this.password,
    required this.email,
  });
  
  // Factory constructor to return the singleton isntance
  factory Administrator() => _instance;

  // Admin methods
  bool login(String username, String password) {
    if (this.username == username && this.password == password) {
      isLoggedIn = true;
      return true;
    }
    return false;
  }

  void logout() {
    isLoggedIn = false;
  }

  void addStudent(Student student) {
    if(!isLoggedIn) {
      throw Exception('Administrator must be logged in to add students.');
    }
    students.add(student);
  }

  void removeStudent(String studentId) {
    if(!isLoggedIn) {
      throw Exception('Administrator must be logged in to remove students.');
    }
    students.removeWhere((student) => student.id == studentId);
  }

  Student? findStudent(String studentId) {
    return students.firstWhere((student) => student.id == studentId,
    orElse: () => throw Exception('Student not found'),
    );
  }

  void updateStudentGrade(String studentId, double grade) {
    if (!isLoggedIn) {
      throw Exception('Administrator must be logged in to update grades');
    }
    var student = findStudent(studentId);
    student?.addGrade(grade);
  }

  List<Student> getFailingStudents() {
    return students.where((student) => !student.isPassignStudent()).toList();  
  }


  List<Student> getPassingStudents() {
    return students.where((student) => student.isPassignStudent()).toList();  
  }

  // Statistics and Reporting
  double getClassAverage() {
    if (students.isEmpty) return 0.0;
    var total = students.fold(0.0, (sum, student) => sum + student.averageGrade);
    return total / students.length;
  }
  @override
  String toString() {
    return '''
    Administrator ID: $adminId
    Username: $username
    Email: $email
    Login Status: ${isLoggedIn ? 'Logged In' : 'Logged Out'}
    ''';
  }
  
}