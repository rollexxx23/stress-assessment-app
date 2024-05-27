import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/auth.dart';
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
              const SizedBox(height: 30),
              Image.asset(
                "assets/login_image.png",
                height: 200,
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "LOGIN WITH EMAIL",
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
                  FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
                      email: emailController.text,
                      password: pwController.text,
                      context: context);
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
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
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
