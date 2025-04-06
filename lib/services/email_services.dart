import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Initialize Firebase (should be done in main.dart typically)
Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}

// Modified sendEmail function
Future sendEmail({
  required String username,
  required String subject,
  required String message,
}) async {
  try {
    // Get current user's email from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("No user signed in");
      throw Exception("User must be signed in to send email");
    }

    String email = user.email ?? '';
    if (email.isEmpty) {
      log("User email not found");
      throw Exception("User email not available");
    }

    const serviceid = 'service_2sghuio';
    const templetid = 'template_1qpmx9k';
    const userid = 'iQDFG_-IF0vFYRcQS';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'origin': 'http://localhost'
      },
      body: json.encode(
        {
          'user_id': userid,
          'service_id': serviceid,
          'template_id': templetid,
          'template_params': {
            'user_name': username,
            'to_email': email,  // Using Firebase user's email
            'user_subject': subject,
            'user_message': message,
          }
        },
      ),
    );

    if (response.statusCode != 200) {
      log("Email not sent: ${response.body}");
    } else {
      log("Email sent successfully to $email");
    }

    return response.statusCode == 200;
  } catch (e) {
    log("Error sending email: $e");
    rethrow;
  }
}

// Example usage:
void main() async {
  try {
    // Initialize Firebase first (typically in your app's main function)
    await initializeFirebase();

    // Make sure a user is signed in
    // You would typically handle authentication flow separately
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "user@example.com",
      password: "password123",
    );

    // Send email using the function
    await sendEmail(
      username: "John Doe",
      subject: "Test Subject",
      message: "Hello from Firebase integration!",
    );
  } catch (e) {
    log("Error in main: $e");
  }
}