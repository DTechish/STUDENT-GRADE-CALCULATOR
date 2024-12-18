import 'dart:io';
import 'dart:math';

import 'package:grade_calculator/student/student.dart';
import 'package:grade_calculator/email_sender.dart';
import 'package:grade_calculator/student/student_data.dart';
import '../general_functions.dart';
import 'student_validator.dart';

// Handles the student login process
Future<void> handleStudentLogin() async {
  StudentData students = StudentData();
  const int maxLoginAttempts = 3;
  int loginAttempts = 0;
  bool studentLoggedIn = false;

  do {
    String? studentId = _promptForStudentId();
    String? password = _promptForPassword();

    Student? student = _findStudentById(students, studentId);

    if (student != null && student.validatePassword(password ?? '')) {
      print('\nLogin successful!');
      studentLoggedIn = true;
      handleStudentMenu(student);
    } else {
      loginAttempts++;
      print('\nInvalid credentials!');

      if (loginAttempts >= maxLoginAttempts) {
        await _handleMaxLoginAttempts(student);
        break; // Exit the login loop after handling max attempts
      }
    }
  } while (!studentLoggedIn);
}

// Prompts for student ID input
String? _promptForStudentId() {
  stdout.write('Enter Student ID: ');
  return stdin.readLineSync();
}

// Prompts for password input
String? _promptForPassword() {
  stdout.write('Enter Password: ');
  return stdin.readLineSync();
}

// Finds a student by ID
Student? _findStudentById(StudentData students, String? studentId) {
  for (var s in students.studentsList) {
    if (s.id.toString() == studentId) {
      return s; // Return the matching student
    }
  }
  return null; // Return null if no match is found
}

Student? _findStudentByEmail(StudentData students, String? email) {
  for (var s in students.studentsList) {
    if (s.email == email) {
      return s; // Return the matching student
    }
  }
  // Return null if no matching student is found
  return null;
}

// Handles actions when maximum login attempts are reached
Future<void> _handleMaxLoginAttempts(Student? student) async {
  print('Maximum login attempts reached.');

  // Check if the student is null (indicating they may not exist)
  if (student == null) {
    // Prompt for email if student does not exist
    stdout.write('\nPlease enter your registered email for password reset: ');
    String? emailInput = stdin.readLineSync();

    // Check if the email exists in the database
    Student? foundStudent = _findStudentByEmail(
        StudentData(), emailInput); // Pass StudentData instance

    if (foundStudent != null) {
      // If the email matches a student, allow password reset
      await _resetPassword(foundStudent);
    } else {
      print('No account associated with the provided email.');
    }
  } else {
    // If student is not null, proceed with the existing flow
    stdout.write('\nWould you like to reset your password? (y/n): ');
    String? resetChoice = stdin.readLineSync()?.toLowerCase();

    if (resetChoice == 'y' && _hasEmail(student)) {
      await _resetPassword(student);
    } else if (resetChoice == 'y') {
      print('No email associated with this student account.');
    } else {
      print('Password reset cancelled.');
    }
  }
}

// Checks if the student has an email
bool _hasEmail(Student student) {
  return student.email != null && student.email.isNotEmpty;
}

// Resets the student's password
Future<void> _resetPassword(Student student) async {
  // Generate verification code
  final String verificationCode =
      (100000 + Random().nextInt(900000)).toString();
  print(
      'Verification code generated: $verificationCode'); // For testing, you can remove this line in production

  // Send email directly
  bool emailSent = await sendVerificationEmail(student.email, verificationCode);

  if (!emailSent) {
    print('Failed to send verification email. Please try again.');
    return;
  }

  // Prompt for verification code
  int maxAttempts = 3;
  for (int attempt = 0; attempt < maxAttempts; attempt++) {
    stdout.write('Enter the 6-digit verification code sent to your email: ');
    String? userCode = stdin.readLineSync();

    if (userCode == verificationCode) {
      _updatePassword(student);
      return; // Successfully reset password
    } else {
      print(
          'Incorrect verification code. ${maxAttempts - attempt - 1} attempts remaining.');
    }
  }

  //VerificationCodeManager.resetVerificationCode(); // Reset code after max attempts
  print('Too many incorrect attempts. Password reset cancelled.');
}

// Prompts for a new password and updates it
void _updatePassword(Student student) {
  String? newPassword;

  while (true) {
    stdout.write('\nEnter new password: ');
    newPassword = stdin.readLineSync();

    // Validate the new password
    try {
      if (newPassword != null) {
        StudentValidator.validatePassword(newPassword);
        break; // If validation passes, exit the loop
      }
    } catch (e) {
      print("Error: ${e.toString()}"); // Print validation error
    }
  }

// Update the student's password
  student.resetPassword(newPassword);
  print(
      '\nPassword reset successful! You can now log in with your new password.');

}

// Displays the student menu options
void showStudentMenu() {
  print('\nSTUDENT MENU');
  print('''
1. View My Grades
2. Calculate GPA
3. Logout
''');
}

// Handles the student menu interactions
void handleStudentMenu(Student student) {
  bool shouldContinue = true;

  while (shouldContinue) {
    showStudentMenu();
    int choice = getUserChoice(1, 3);

    switch (choice) {
      case 1:
        print('Viewing grades...');
        break;
      case 2:
        print('Calculating GPA...');
        break;
      case 3:
        print('Logging out...');
        shouldContinue = false;
        break;
    }
  }
}

// Displays the student submenu options
void displaySubMenu() {
  print('\nSTUDENTS MENU\n');
  print('''
1. SIGN UP
2. LOGIN
3. BACK TO MAIN MENU
''');
}
