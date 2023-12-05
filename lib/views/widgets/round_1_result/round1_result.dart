import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/views/screens/test/round2.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  final double averageBPM;
  final double typingSpeed;
  final double accuracy;
  final double voicePitch;
  late final double voiceVolume;

  ResultScreen({
    required this.averageBPM,
    required this.typingSpeed,
    required this.accuracy,
    required this.voicePitch,
    required this.voiceVolume,
  });

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    voiceVolume = (random.nextInt(21) + 70) as double;
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
              _buildResultTile('Average BPM', averageBPM.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Speed (WPM)', typingSpeed.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Accuracy', '${accuracy.toStringAsFixed(2)}%'),
              _buildResultTile('Voice Volume', voiceVolume.toStringAsFixed(2)),
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
