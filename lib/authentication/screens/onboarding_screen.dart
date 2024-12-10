import 'package:flutter/material.dart';

// Import the QuestionScreen file
import 'question_screen.dart'; // Ensure this matches the file name where `QuestionScreen` is defined
import 'login_screen.dart'; // Ensure this matches the file name where `QuestionScreen` is defined

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded section for the top (can be replaced with an image or logo)
            Expanded(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    '', // Intentionally left blank as per your design
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Buttons Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the QuestionScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE67E22), // Orange color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Space between buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to the login screen
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        color: Color(0xFF27AE60), // Green border
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'I ALREADY HAVE AN ACCOUNT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF27AE60), // Green text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// Entry point
void main() {
  runApp(MaterialApp(
    home: OnboardingScreen(),
  ));
}
