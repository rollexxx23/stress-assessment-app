import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:frontend/views/screens/home_screen.dart';
import 'package:frontend/views/screens/login_screen.dart';
import 'package:frontend/views/widgets/snackbar.dart';
import 'package:get/get.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!);
    }
    Get.offAll(const LoginScreen());
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        // ignore: use_build_context_synchronously
        await sendEmailVerification(context);
      } else {
        Get.offAll(const HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Verification Email Sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}

class FirebaseService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String email, String name) async {
    try {
      await _userCollection.add({
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding task: $e");
    }
  }
}
