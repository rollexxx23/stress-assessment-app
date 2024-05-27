import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/globals.dart';

class TestDataCrud {
  void createRoom() {
    FirebaseFirestore.instance.collection('data').add({
      "room_id": generateRandomId(),
      "created_by": FirebaseAuth.instance.currentUser!.email,
      'createdAt': FieldValue.serverTimestamp(),
    }).then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
    }).catchError((error) {
      print('Error adding document: $error');
    });
  }

  Future<void> updateRoomData(int roomId, Map<String, dynamic> newData) async {
    try {
      CollectionReference rooms = FirebaseFirestore.instance.collection('data');

      QuerySnapshot querySnapshot =
          await rooms.where('room_id', isEqualTo: roomId).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentRef = querySnapshot.docs.first.reference;
        await documentRef.update(newData);
        print('Document with roomId $roomId updated successfully.');
      } else {
        print('No document found with roomId $roomId.');
      }
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  int generateRandomId({int min = 10000, int max = 99999}) {
    Random random = Random();
    int val = min + random.nextInt(max - min + 1);
    currRoomId.value = 89610;
    return 89610;
  }
}
