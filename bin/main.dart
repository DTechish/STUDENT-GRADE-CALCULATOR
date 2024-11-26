import 'dart:io';

import 'package:grade_calculator/administrator.dart';
import 'package:grade_calculator/student.dart';
import 'package:grade_calculator/student_auth_service.dart';

final StudentAuthService studentAuthService = StudentAuthService();

void main() {
  bool shouldRun = true;

  int minValue = 1;
  int maxValue = 3;

  List<Student> students = [
  Student(
    'John Doe',        // Name
    12345,             // ID
    20,                // Age
    'Male',            // Gender
    'Computer Science',// Major
    'password123',     // Password
    'john.doe@email.com' // Email
  ),
  Student(
    'Emma Watson',     // Name
    54321,             // ID
    22,                // Age
    'Female',          // Gender
    'Data Science',    // Major
    'emma2023!',       // Password
    'emma.watson@email.com' // Email
  ),
  Student(
    'Michael Chen',    // Name
    67890,             // ID
    21,                // Age
    'Male',            // Gender
    'Software Engineering', // Major
    'secure456',       // Password
    'michael.chen@email.com' // Email
  ),
  Student(
    'Sarah Johnson',   // Name
    98765,             // ID
    19,                // Age
    'Female',          // Gender
    'Artificial Intelligence', // Major
    'sarah2023@',      // Password
    'sarah.johnson@email.com' // Email
  ),
  Student(
    'David Kim',       // Name
    24680,             // ID
    23,                // Age
    'Male',            // Gender
    'Cybersecurity',   // Major
    'davidpass123',    // Password
    'david.kim@email.com' // Email
  )
  ];

  do {
    displayMainMenu();

    try {
      int choice = getUserChoice(minValue, maxValue);

      switch (choice) {
        case 1:
          handleAdminLogin();
          break;
        case 2:
          displaySubMenu();
          choice = getUserChoice(minValue, maxValue);
          if (choice == 1) {
          } else if (choice == 2) {
            handleStudentLogin();
          }
          break;
        case 3:
          print('\nThanks for using our application!\n');
          shouldRun = false;
          break;
      }
    } catch (error) {
      print('\nAn unexpected error occurred. Please try again.');
    }
  } while (shouldRun);
}

int getUserChoice(int min, int max) {
  while (true) {
    try {
      // Read user input and handle null case
      stdout.write('Select option($min-$max): ');
      String? rawInput = stdin.readLineSync();

      if (rawInput == null || rawInput.trim().isEmpty) {
        throw ArgumentError('Input cannot be empty');
      }

      // Try to parse the input as integer
      int userInput = int.parse(rawInput.trim());

      // Validate if input is within acceptable range
      if (userInput < min || userInput > max) {
        throw RangeError('Please enter a number between $min and $max');
      }

      return userInput;
    } on FormatException {
      print('\nError: Enter a valid number.');
    } on RangeError catch (error) {
      print('\nError: ${error.message}');
    } on ArgumentError catch (error) {
      print('\nError: ${error.message}');
    }
  }
}

void displayMainMenu() {
  print('GRADE CALCULATOR LOGIN\n');
  print('''
  1. ADMIN
  2. STUDENT
  3. QUIT
''');
}

void handleAdminLogin() {
  var admin = Administrator(); // Get singleton instance
  bool adminLoggedIn = false;

  do {
    stdout.write('Enter username: ');
    String? username = stdin.readLineSync();

    stdout.write('Enter password: ');
    String? password = stdin.readLineSync();

    if (username != null && password != null) {
      if (admin.login(username, password)) {
        adminLoggedIn = true;
        print('\nLogin sucessful!');
        handleAdminMenu(admin);
      } else {
        print('\nInvalid credentials!');

        stdout.write('Would you like to try again? (y/n): ');
        String? retry = stdin.readLineSync()?.toLowerCase();

        if (retry != 'y') break;
      }
    }
  } while (!adminLoggedIn);
}

// Add a new function to handle admin menu
void handleAdminMenu(Administrator admin) {}

void handleStudentLogin() {
  stdout.write('Enter student ID: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');

  if (id == null) {
    print('Invalid student ID');
    return;
  }

  stdout.write('Enter password: ');
  String? password = stdin.readLineSync();

  if (password == null) {
    print('Password cannot be empty');
    return;
  }

  var student = studentAuthService.login(id, password);
  if (student != null) {
    print('Login successful');
    // Proceed to student menu
  } else {
    stdout.write('Would you like to reset your password? (y/n): ');
    String? resetChoice = stdin.readLineSync()?.toLowerCase();

    if (resetChoice == 'y') {
      stdout.write('Enter your email: ');
      String? email = stdin.readLineSync();

      if (email != null) {
        studentAuthService.requestPasswordReset(id, email);
      }
    }
  }
}

void displaySubMenu() {
  print('STUDENTS MENU\n');
  print('''
  1. SIGN UP
  2. LOGIN
  3. BACK TO MAIN MENU
''');
}

void showAdminMenu() {
  print('\nADMIN MENU');
  print('''
1.Logout''');
}

void showStudentMenu() {
  print('\nSTUDENT MENU');
  print('''
1. View My Grades
2. Calculate GPA
3. Logout''');
}
