class StudentValidator {
  static void validate(String name, int age, String gender,
      String password, String email) {
    _validateName(name);
    _validateAge(age);
    _validateGender(gender);
    _validateEmail(email);
  }

  static void _validateName(String name) {
    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }

    if (name.length < 3 || name.length > 50) {
      throw ArgumentError('Nmae must be between 3 and 50 characters long');
    }

    if (name != name.trim()) {
      throw ArgumentError('Name cannot have leading or trailing spaces');
    }

    if (name.contains('  ')) {
      throw ArgumentError(' Name cannot contain consecutive spaces');
    }

    final validCharacters = RegExp(r"^[a-zA-Z\s'-]+$");
    if (!validCharacters.hasMatch(name)) {
      throw ArgumentError(
          'Name can only contain letters, spaces, hyphens and apostrophes');
    }
  }

  // name = name.split(' ').map((part) => part[0].toUpperCase() + part.substring(1).toUpperCase()).join(' ');

  static void _validateAge(int age) {
    if (age < 0) {
      throw ArgumentError('Age cannot be negative');
    }

    // Define resonable age limits
    const int minimumAge = 6;
    const int maximumAge = 120;

    if (age < minimumAge || age > maximumAge) {
      throw ArgumentError('Age must be between $minimumAge adn $maximumAge');
    }
  }

  static void _validateGender(String gender) {
    if (gender.isEmpty || gender.trim().isEmpty) {
      throw ArgumentError('Gender cannot be empty');
    }

    gender = gender[0].toUpperCase();

    // Allowed gender values
    const allowedGenders = ['Male', 'Female'];
    if (!allowedGenders.contains(gender)) {
      throw ArgumentError(
          'Gender must be one of the following: ${allowedGenders.join(',')}');
    }
  }

  static void _validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if(!emailRegExp.hasMatch(email)) {
      throw ArgumentError('Invalid email address');
    }
  }
}
