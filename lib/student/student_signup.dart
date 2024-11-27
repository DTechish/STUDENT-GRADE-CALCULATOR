import 'dart:io';
import 'student.dart';

void studentSignup() {
  print('\nSTUDENT SIGN UP SCREEN\n');
  // Request user's name
  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync()?.trim() ?? "Unknown Name";

  // Request user's age
  stdout.write("Enter your age: ");
  int? age = int.tryParse(stdin.readLineSync()?.trim() ?? "");

  // Request user's gender
  stdout.write("Enter your gender (Male/Female): ");
  String? genderInput = stdin.readLineSync()?.trim() ?? "";
  String gender = genderInput.isNotEmpty ? genderInput[0].toUpperCase() + genderInput.substring(1).toLowerCase() : "Unknown";

  // Request user's major
  stdout.write("Enter your major: ");
  String? major = stdin.readLineSync()?.trim() ?? "Undeclared";

  // Request user's email
  stdout.write("Enter your email: ");
  String? email = stdin.readLineSync()?.trim() ?? "unknown@example.com";

  // Request user's password
  stdout.write("Enter your password: ");
  String? password = stdin.readLineSync()?.trim() ?? "defaultPassword";

  // Generate a unique ID (this is a placeholder; implement your own logic)
  int uniqueId = DateTime.now().millisecondsSinceEpoch; // Example unique ID generation

  // Create a new Student object
  try {
    Student student = Student(
      name,
      uniqueId,
      age ?? 0,
      gender,
      major,
      password,
      email,
    );

    print("Student created successfully!");
    print(student); // Display the created student information
  } catch (e) {
    print("Error: ${e.toString()}");
  }
}