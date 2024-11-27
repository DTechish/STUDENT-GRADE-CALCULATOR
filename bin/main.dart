import 'package:grade_calculator/admin/admin_login.dart';
import 'package:grade_calculator/general_functions.dart';
import 'package:grade_calculator/student/student_login.dart';

void main() async {
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
          while (true) {
            displaySubMenu();
            choice = getUserChoice(minValue, maxValue);
            if (choice == 1) {
            } else if (choice == 2) {
              await handleStudentLogin();
            } else if (choice == 3) {
              break;
            }
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

void displayMainMenu() {
  print('\nGRADE CALCULATOR LOGIN\n');
  print('''
  1. ADMIN
  2. STUDENT
  3. QUIT

''');
}
