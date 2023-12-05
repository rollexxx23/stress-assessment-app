import 'dart:math';

import 'package:flutter/material.dart';

class TypeTestWidget extends StatefulWidget {
  String level;
  final Function(double, double) onDataPassed;
  TypeTestWidget({super.key, required this.level, required this.onDataPassed});

  @override
  State<TypeTestWidget> createState() => _TypeTestWidgetState();
}

class _TypeTestWidgetState extends State<TypeTestWidget> {
  Set<int> wrongWords = {};
  late List<String> wordList;
  late int currentIdx;
  late TextEditingController textController;
  @override
  void initState() {
    wordList = generateRandomParagraph();
    textController = TextEditingController();
    currentIdx = 0;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    double wpm = max(0, (currentIdx - 1) * 2);
    double efficiency = (1 - (wrongWords.length) / currentIdx) * 100;
    widget.onDataPassed(wpm, efficiency);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to Round ${widget.level}, Here Your Typing Ability(WPM and Accuracy) will be recoreded under stress-free condition. Type The Given Paragraph',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        Container(
          width: MediaQuery.of(context).size.width *
              0.9, // 90% width of the screen
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0), // Rounded border
          ),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: RichText(
            text: TextSpan(
              children: [
                for (int i = 0; i < wordList.length; i++)
                  TextSpan(
                    text: "${wordList[i]} ",
                    style: TextStyle(
                      fontSize: 18,
                      color: i == currentIdx
                          ? Colors.white
                          : (currentIdx > i)
                              ? (!wrongWords.contains(i))
                                  ? Colors.green
                                  : Colors.red
                              : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: wordList[currentIdx],
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
                ),
              ),
              onChanged: (val) {
                if (val[val.length - 1] == ' ') {
                  setState(() {
                    if (currentIdx < 24) {
                      if (val.substring(0, val.length - 1) !=
                          wordList[currentIdx]) {
                        wrongWords.add(currentIdx);
                      }
                      textController.clear();
                      currentIdx++;
                    }
                  });
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

List<String> generateRandomParagraph() {
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

  return generatedWords;
}
