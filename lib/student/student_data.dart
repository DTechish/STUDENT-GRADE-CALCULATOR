import 'package:grade_calculator/student/student.dart';

class StudentData {


    // List to store students
  final List<Student> _students = [
    Student(
      'John Doe', // Name
      12345, // ID
      20, // Age
      'Male', // Gender
      'Computer Science', // Major
      'password123', // Password
      'programmerdanny10@gmail.com' // Email
      ),
  Student(
      'Emma Watson', // Name
      54321, // ID
      22, // Age
      'Female', // Gender
      'Data Science', // Major
      'emma2023!', // Password
      'dtechish@gmail.com' // Email
      ),
  Student(
      'Michael Chen', // Name
      67890, // ID
      21, // Age
      'Male', // Gender
      'Software Engineering', // Major
      'secure456', // Password
      'dna10296@gmail.com' // Email
      ),
  Student(
      'Sarah Johnson', // Name
      98765, // ID
      19, // Age
      'Female', // Gender
      'Artificial Intelligence', // Major
      'sarah2023@', // Password
      'sarah.johnson@email.com' // Email
      ),
  Student(
      'David Kim', // Name
      24680, // ID
      23, // Age
      'Male', // Gender
      'Cybersecurity', // Major
      'davidpass123', // Password
      'david.kim@email.com' // Email
      )
  ];

  // Getter for students
  List<Student> get studentsList => List.unmodifiable(_students);
}