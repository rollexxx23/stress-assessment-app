import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/testdata_crud.dart';
import 'package:frontend/globals.dart';
import 'package:get/get.dart';

import '../../screens/test/round3.dart';

class Result2Screen extends StatefulWidget {
  const Result2Screen({super.key});

  @override
  State<Result2Screen> createState() => _Result2ScreenState();
}

class _Result2ScreenState extends State<Result2Screen> {
  late double voiceVolume;
  @override
  void initState() {
    TestDataCrud().updateRoomData(currRoomId.value, {
      "bpm_2": hrv_2.value,
      "wpm_2": wpm_2.value,
      "accuracy_2": efficiency_2.value,
      "volume_2": voiceVolume_2.value,
      "pitch_2": voicePitch_2.value,
      "quiz_1": quiz1_2.value,
      "quiz_2": quiz2_2.value,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Here Are Your Measured Values For Round 2',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              _buildResultTile('Average BPM', hrv_2.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Speed (WPM)', wpm_2.value.toStringAsFixed(2)),
              _buildResultTile('Typing Accuracy',
                  '${efficiency_2.value.toStringAsFixed(2)}%'),
              _buildResultTile(
                  'Voice Volume', voiceVolume_2.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Quiz 1 Score', quiz1_2.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Quiz 2 Score', quiz2_2.value.toStringAsFixed(2)),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(Round3());
                },
                child: const Text('Next Round'),
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
