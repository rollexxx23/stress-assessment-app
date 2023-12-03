import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/firebase_auth_methods.dart';
import 'package:frontend/views/screens/signup_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController pwController;

  void loginUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
      email: emailController.text,
      password: pwController.text,
      context: context,
    );
  }

  @override
  void initState() {
    emailController = TextEditingController();
    pwController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    color: Color(0xff3F414E),
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 50),
              Container(
                width: 300, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38.0),
                  color: const Color(0xFF8E97FD), // Use the color code
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/facebook.png"),
                      const Text(
                        "CONTINUE WITH FACEBOOK",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 15.0, // Text size
                        ),
                      ),
                      const SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 300, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38.0),
                  color: Colors.white, // Use the color code
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF3F414E), // Border color
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/google.png"),
                      const Text(
                        "CONTINUE WITH GOOGLE",
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 15.0, // Text size
                        ),
                      ),
                      const SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "OR LOGIN WITH EMAIL",
                  style: TextStyle(
                      color: Color(0xffA1A4B2),
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 300, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFE6E7EB), // Use the color code
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        labelStyle: TextStyle(
                          color: Colors
                              .grey, // You can adjust the label text color
                        ),
                        border: InputBorder.none, // Remove the border
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 300, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFE6E7EB), // Use the color code
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: TextField(
                      controller: pwController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Pasword",
                        labelStyle: TextStyle(
                          color: Colors
                              .grey, // You can adjust the label text color
                        ),
                        border: InputBorder.none, // Remove the border
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  loginUser();
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
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 15.0, // Text size
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "FORGOT PASSWORD?",
                  style: TextStyle(
                      color: Color(0xffA1A4B2),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Color(0xffA1A4B2),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const SignupScreen());
                    },
                    child: const Text(
                      "Sign Up",
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
      ),
    );
  }
}
