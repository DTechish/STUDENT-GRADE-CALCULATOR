import 'dart:io';

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


