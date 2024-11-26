import 'dart:io';

import 'package:grade_calculator/administrator.dart';

void main() {
  bool shouldRun = true;

  int minValue = 1;
  int maxValue = 3;

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
  String? id = stdin.readLineSync();

  stdout.write('Enter password: ');
  String? password = stdin.readLineSync();
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
