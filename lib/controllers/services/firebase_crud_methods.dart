import 'package:cloud_firestore/cloud_firestore.dart';

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
