import 'package:flutter/material.dart';
import 'package:frontend/views/screens/login_screen.dart';
import 'package:frontend/views/screens/signup_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Stress",
                  style: TextStyle(
                      color: Color(0xff3F414E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset("assets/logo.png"),
                const Text(
                  "Detect",
                  style: TextStyle(
                      color: Color(0xff3F414E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Image.asset("assets/intro_screen.png"),
            const SizedBox(height: 80),
            const Text(
              "What are we what we do",
              style: TextStyle(
                  color: Color(0xff3F414E),
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Thousand of people are usign Stress Detect \nfor stress assesment",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffA1A4B2),
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                Get.to(const SignupScreen());
              },
              child: Container(
                width: 300, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38.0),
                  color: const Color(0xFF8E97FD), // Use the color code
                ),
                child: const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 15.0, // Text size
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Color(0xffA1A4B2),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const LoginScreen());
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        color: Color(0xff8E97FD),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
