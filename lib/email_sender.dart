import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:dotenv/dotenv.dart';

// Modify your email sender to be asynchronous
Future<bool> sendVerificationEmail(
    String recipientEmail, String verificationCode) async {
  try {
    // Your existing email sending logic
    final envFile = File('.env');

    if (!envFile.existsSync()) {
      print('Error: .env file not found.');
      return false;
    }

    final env = DotEnv()..load();

    String username = env['USERNAME']!;
    String password = env['PASSWORD']!;

    // Use a no-reply email address
    const String noReplyEmail = 'no-reply@example.com';
    const String invalidReplyToEmail = 'no-reply@invalid-domain.com'; // An invalid or non-existent email

    print('\nAttempting to send verification email to $recipientEmail...');

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(noReplyEmail, 'Grade Calculator App')
      ..recipients.add(recipientEmail)
      ..subject = 'Password Reset Verification Code'
      ..text = '''
      Hello,

      You have requested a password reset for your Grade Calculator account.
      
      Your verification code is: $verificationCode

      If you did not request this reset, please ignore this email.

      Best regards,
      Grade Calculator Team
      '''
      ..headers['Reply-To'] = invalidReplyToEmail; // Set Reply-To to an invalid addres

    // Send the email synchronously
    await send(message, smtpServer);
    print('Email sent successfully!');
    return true;
  } catch (e) {
    print('=== EMAIL SENDING FAILED ===');
    print('Recipient: $recipientEmail');
    print('Error: $e');
    return false;
  }
}
