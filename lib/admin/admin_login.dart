import 'dart:io';

import '../general_functions.dart';
import 'administrator.dart';

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

void showAdminMenu() {
  print('\nADMIN MENU');
  print('''
1.Logout''');
}

void handleAdminMenu(Administrator admin) {
  bool shouldContinue = true;

  while (shouldContinue) {
    showAdminMenu();

    int choice = getUserChoice(1, 1);

    switch (choice) {
      case 1:
        print('Logging out...');
        shouldContinue = false;
        break;
    }
  }
}


