import 'dart:async';
import 'dart:math';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordVoiceScreen extends StatefulWidget {
  final Function(double, double) onDataPassed;
  RecordVoiceScreen({super.key, required this.onDataPassed});
  @override
  _RecordVoiceScreenState createState() => _RecordVoiceScreenState();
}

class _RecordVoiceScreenState extends State<RecordVoiceScreen> {
  // FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;
  late String paragraph;
  @override
  void initState() {
    // TODO: implement initState
    paragraph = generateRandomParagraph();
    super.initState();
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    widget.onDataPassed(
        _latestReading?.meanDecibel ?? 0, _latestReading?.maxDecibel ?? 0);
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    print("called${noiseReading.meanDecibel}");

    setState(() {
      _latestReading = noiseReading;
    });
  }

  void onError(Object error) {
    print(error);
    stop();
  }

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  /// Start noise sampling.
  Future<void> start() async {
    // Create a noise meter, if not already done.
    noiseMeter ??= NoiseMeter();

    if (!(await checkPermission())) await requestPermission();

    // Listen to the noise stream.
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() => _isRecording = true);
  }

  /// Stop sampling.
  void stop() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Round 1.4, Here Your Voice will be recoreded under stress-free condition. Read Out The Given Paragraph',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                paragraph,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.all(25),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(_isRecording ? "Mic: ON" : "Mic: OFF",
                        style:
                            const TextStyle(fontSize: 25, color: Colors.blue)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Noise: ${_latestReading?.meanDecibel.toStringAsFixed(2)} dB',
                    ),
                  ),
                  Text(
                    'Max: ${_latestReading?.maxDecibel.toStringAsFixed(2)} dB',
                  )
                ])),
            ElevatedButton(
              onPressed: () {
                _isRecording ? stop() : start();
                // setState(() {
                //   _isRecording = !_isRecording;
                // });
              },
              child: (_isRecording == false)
                  ? const Text('Start Recording')
                  : const Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }

  String generateRandomParagraph() {
    List<String> wordList = [
      'apple',
      'banana',
      'orange',
      'grape',
      'pear',
      'dog',
      'cat',
      'rabbit',
      'hamster',
      'bird',
      'sun',
      'moon',
      'star',
      'sky',
      'cloud',
      'ocean',
      'river',
      'mount',
      'green',
      'brown',
      'book',
      'pen',
      'music',
      'happy',
      'laugh',
      'child',
      'sunny',
      'beach',
      'smile',
      'grass',
      'color',
      'shape',
      'heart',
      'trail',
      'dream',
      'sweet',
      'spice',
      'flame',
      'dance',
      'shine',
      'enjoy',
      'glass',
      'magic',
      'storm',
      'peace',
      'light',
      'cloud',
      'happy',
      'dream',
      'fresh',
      'space',
      'frost',
      'earth',
      'green',
      'crisp',
      'sweet',
      'sound',
      'happy',
      'sunny',
      'smart',
    ];
    Random random = Random();
    List<String> generatedWords = [];

    for (int i = 0; generatedWords.length != 25; i++) {
      int randomIndex = random.nextInt(wordList.length);
      if (generatedWords.contains(wordList[randomIndex])) {
        continue;
      }
      generatedWords.add(wordList[randomIndex]);
    }

    String paragraph = generatedWords.join(' ');
    return paragraph;
  }
}
