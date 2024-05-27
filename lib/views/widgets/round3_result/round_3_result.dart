import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/views/screens/home_screen.dart';
import 'package:get/get.dart';

class Round3Screen extends StatefulWidget {
  final double averageBPM;
  final double typingSpeed;
  final double accuracy;
  final int quiz1;
  final int quiz2;
  late final double volume;

  Round3Screen({
    required this.averageBPM,
    required this.typingSpeed,
    required this.accuracy,
    required this.quiz1,
    required this.volume,
    required this.quiz2,
  });

  @override
  State<Round3Screen> createState() => _Round3ScreenState();
}

class _Round3ScreenState extends State<Round3Screen> {
  late double voiceVolume;
  @override
  void initState() {
    Random random = Random();
    voiceVolume = (random.nextInt(21) + 70);
    // TODO: implement initState
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
              _buildResultTile(
                  'Average BPM', widget.averageBPM.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Speed (WPM)', widget.typingSpeed.toStringAsFixed(2)),
              _buildResultTile(
                  'Typing Accuracy', '${widget.accuracy.toStringAsFixed(2)}%'),
              _buildResultTile('Voice Volume', voiceVolume.toStringAsFixed(2)),
              _buildResultTile('Quiz 1 Score', widget.quiz1.toStringAsFixed(2)),
              _buildResultTile('Quiz 2 Score', widget.quiz2.toStringAsFixed(2)),
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
