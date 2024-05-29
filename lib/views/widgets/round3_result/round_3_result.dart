import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/testdata_crud.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/views/screens/home_screen.dart';
import 'package:get/get.dart';

class Round3Screen extends StatefulWidget {
  const Round3Screen({
    super.key,
  });

  @override
  State<Round3Screen> createState() => _Round3ScreenState();
}

class _Round3ScreenState extends State<Round3Screen> {
  @override
  void initState() {
    TestDataCrud().updateRoomData(currRoomId.value, {
      "bpm_3": hrv_3.value,
      "wpm_3": wpm_3.value,
      "accuracy_3": efficiency_3.value,
      "volume_3": voiceVolume_3.value,
      "pitch_3": voicePitch_3.value,
      "quiz_3": quiz1_3.value,
      "quiz_4": quiz2_3.value,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Here Are Your Measured Values For Round 3',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              _buildResultTile('Average BPM', hrv_3.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Speed (WPM)', wpm_3.value.toStringAsFixed(2)),
              _buildResultTile('Typing Accuracy',
                  '${efficiency_3.value.toStringAsFixed(2)}%'),
              _buildResultTile(
                  'Voice Volume', voiceVolume_3.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Quiz 1 Score', quiz1_3.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Quiz 2 Score', quiz2_3.value.toStringAsFixed(2)),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(const HomeScreen());
                },
                child: const Text('Go To HomeScreen'),
              ),
            ],
          ),
        ));
  }

  Widget _buildResultTile(String title, String value) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
