A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/` (yet to be created).

Basically this personal project is still in development process.



## Setup Instructions

Follow these steps to set up the project:

1. **Create the Environment File**:
   - In the root of the project folder, create a new file named `.env`. You can do this using a text editor or by running:
     ```bash
     touch .env
     ```

3. **Copy Configuration**:
   - Open the file named `.env.example` in a text editor.
   - Copy all the contents from `.env.example` and paste them into your newly created `.env` file.

4. **Update Your Credentials**:
   - In the `.env` file, locate the placeholder values for email and password.
   - Replace the placeholders with your actual email and password:
     ```plaintext
     USERNAME=your-email@example.com
     PASSWORD=your-email-password
     ```

   **Important**: If your actual email password does not work when you run the application, you may need to create an **App Password**. This is a special password that allows you to access your email securely. Here’s how to create one:
   - **Creating an App Password**:
     - Log in to your email account.
     - Go to your account settings and look for "Security" or "App Passwords."
     - Follow the instructions to generate a new App Password (it should be 16 characters long and can include spaces).
     - Use this App Password in place of your regular email password in the `.env` file.

5. **Run the Application**:
   - After updating your `.env` file, make sure to save the changes.
   - You may need to close and reopen your IDE or editor to ensure the new environment variables are loaded.
   - Run the application.

---

### Additional Notes

- **Internet Requirement**: Please note that an active internet connection is required for the application to send real emails.
- **Security Reminder**: Keep your `.env` file private and do not share it publicly, as it contains sensitive information.
- **Troubleshooting**: If you experience any issues with authentication, double-check your email and App Password, and refer to your email provider's documentation for additional help.
