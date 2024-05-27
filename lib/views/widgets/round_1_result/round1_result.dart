import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/services/testdata_crud.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/views/screens/test/round2.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    TestDataCrud().updateRoomData(currRoomId.value, {
      "bpm_1": averageBPMRound1.value,
      "wpm_1": typingSpeedRound1.value,
      "accuracy_1": accuracyRound1.value,
      "volume_1": voiceVolumeRound1.value,
      "pitch_1": voicePitchRound1.value
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Here Are Your Measured Values Under Zero Stress.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              _buildResultTile(
                  'Average BPM', averageBPMRound1.value.toStringAsFixed(2)),
              _buildResultTile('Typing Speed (WPM)',
                  typingSpeedRound1.value.toStringAsFixed(2)),
              _buildResultTile('Typing Accuracy',
                  '${accuracyRound1.value.toStringAsFixed(2)}%'),
              _buildResultTile(
                  'Voice Volume', voiceVolumeRound1.value.toStringAsFixed(2)),
              _buildResultTile(
                  'Voice Pitch', voicePitchRound1.value.toStringAsFixed(2)),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(Round2());
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
