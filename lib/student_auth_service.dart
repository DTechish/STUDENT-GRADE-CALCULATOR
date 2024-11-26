import 'dart:io';     // For console input/output
import 'dart:math';   // For generating random numbers
import 'package:grade_calculator/student.dart';           // Student model
import 'package:grade_calculator/student_validator.dart'; // Validation logic

class StudentAuthService {
  // Maximum number of login attempts before locking the account
  static const int maxLoginAttempts = 3;

  // List to store all registered students
  final List<Student> _registeredStudents = [];

  // Map to track login attempts for each student ID
  final Map<int, int> _loginAttempts = {};

  // Method to register a new student
  bool registerStudent(
    String name, 
    int id, 
    int age, 
    String gender, 
    String major, 
    String password, 
    String email
  ) {
    try {
      // Check if a student with the same ID already exists
      // .any() iterates through the list and checks the condition
      if (_registeredStudents.any((s) => s.id == id)) {
        print('Student with this ID already exists');
        return false;
      }
    
      // Create a new Student object
      // This will automatically validate the input using StudentValidator
      Student newStudent = Student(
        name, 
        id, 
        age, 
        gender, 
        major, 
        password, 
        email
      );

      // Add the new student to the list of registered students
      _registeredStudents.add(newStudent);
      print('Student registered successfully');
      return true;
    } catch (e) {
      // Catch and print any validation errors
      print('Registration failed: ${e.toString()}');
      return false;
    }
  }

  // Method to handle student login
  Student? login(int studentId, String password) {
    // Initialize login attempts for this student if not already set
    // ??= is a null-aware assignment operator
    _loginAttempts[studentId] ??= 0;

    // Check if student has exceeded max login attempts
    // ! operator asserts that the value is not null
    if (_loginAttempts[studentId]! >= maxLoginAttempts) {
      print('Too many failed attempts. Please reset your password.');
      return null;
    }

    // Find the student by ID
    Student? student = _findStudentById(studentId);

    // Validate password
    if (student != null && student.validatePassword(password)) {
      // Reset login attempts on successful login
      _loginAttempts[studentId] = 0;
      return student;
    } else {
      // Increment failed login attempts
      // ?? operator provides a default value if the left side is null
      _loginAttempts[studentId] = (_loginAttempts[studentId] ?? 0) + 1;
      print('Invalid credentials. Attempt ${_loginAttempts[studentId]} of $maxLoginAttempts');
      return null;
    }
  }

  // Method to handle password reset request
  bool requestPasswordReset(int studentId, String inputEmail) {
    // Find the student by ID
    Student? student = _findStudentById(studentId);

    // Validate student existence
    if (student == null) {
      print('No student found with this ID');
      return false;
    }

    // Verify email matches
    if (student.email != inputEmail) {
      print('Email does not match');
      return false;
    }

    // Generate a 6-digit verification code
    String verificationCode = _generateVerificationCode();

    // Simulate sending verification code (would be replaced with actual email sending)
    print('Verification code sent to ${student.email}: $verificationCode');

    // Prompt user to enter verification code
    stdout.write('Enter the 6-digit verification code sent to your email: ');
    String? enteredCode = stdin.readLineSync();

    // Verify the entered code
    if (enteredCode == verificationCode) {
      // Prompt for new password
      stdout.write('Enter new password: ');
      String? newPassword = stdin.readLineSync();

      if (newPassword != null) {
        try {
          // Validate the new password using StudentValidator
          StudentValidator.validate(
            student.name, 
            student.age, 
            student.gender, 
            newPassword, 
            student.email
          );

          // Reset the password
          student.resetPassword(newPassword);
          print('Password reset successful');
          return true;
        } catch (e) {
          // Catch and print any password validation errors
          print('Invalid password: ${e.toString()}');
          return false;
        }
      }
    }

    print('Verification failed');
    return false;
  }

  // Private helper method to find a student by ID
  Student? _findStudentById(int studentId) {
    try {
      // Use firstWhere to find the first student with matching ID
      // Throws an error if no matching student is found
      return _registeredStudents.firstWhere((s) => s.id == studentId);
    } catch (e) {
      // Return null if no student is found
      return null;
    }
  }

  // Method to generate a random 6-digit verification code
  String _generateVerificationCode() {
    // Generate a random number between 100000 and 999999
    return Random().nextInt(900000 + 100000).toString();
  }

  // Public method to find a student by ID (optional)
  Student? findStudentById(int studentId) {
    return _findStudentById(studentId);
  }
}