import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/auth.dart';
import 'package:frontend/views/screens/login_screen.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController;
  late TextEditingController pwController;
  late TextEditingController usernameController;

  @override
  void initState() {
    emailController = TextEditingController();
    pwController = TextEditingController();
    usernameController = TextEditingController();
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
                "Create Your Account",
                style: TextStyle(
                    color: Color(0xff3F414E),
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              Image.asset(
                "assets/login_image.png",
                height: 200,
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "SIGNUP WITH EMAIL",
                  style: TextStyle(
                      color: Color(0xffA1A4B2),
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFE6E7EB),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: "User Name",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFE6E7EB),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xFFE6E7EB),
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
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
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
                  FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
                    email: emailController.text,
                    password: pwController.text,
                    context: context,
                  );
                  FirebaseService()
                      .addUser(emailController.text, usernameController.text);
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: const Color(0xFF8E97FD),
                  ),
                  child: const Center(
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 15.0, // Text size
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
      ),
    );
  }
}
