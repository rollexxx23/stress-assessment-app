import 'package:flutter/material.dart';
import 'package:frontend/controllers/ques_generator/ques_generator.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/model/question.dart';

class QuizWidget extends StatefulWidget {
  int round;
  QuizWidget({super.key, required this.round});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late Question currentQues;
  late int currentQuestionIndex;
  late int selectedOption;
  late bool isSelected;
  late bool isCorrect;
  late int score;
  @override
  void initState() {
    currentQuestionIndex = 0;
    selectedOption = -1;
    isSelected = false;
    isCorrect = false;
    score = 0;
    currentQues =
        QuesGenerator.QuesGenerator1("multiplication", currentQuestionIndex);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.round == 0) {
      quiz1_2.value = score;
    } else if (widget.round == 1) {
      quiz2_2.value = score;
    } else if (widget.round == 2) {
      quiz1_3.value = score;
    } else if (widget.round == 3) {
      quiz2_3.value = score;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1}: ${currentQues.question}',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Column(
            children: List.generate(
              currentQues.options.length,
              (index) {
                return ListTile(
                  tileColor: selectedOption == index
                      ? (isCorrect ? Colors.green : Colors.red)
                      : Colors.white,
                  title: Text(
                    currentQues.options[index],
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                  onTap: (!isSelected)
                      ? () {
                          setState(() {
                            if (index == currentQues.answer) {
                              isCorrect = true;
                              score += 2;
                            } else {
                              isCorrect = false;
                              score -= 1;
                            }
                            isSelected = true;
                            selectedOption = index;
                          });
                        }
                      : null,
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (isSelected) {
                nextQuestion();
              }
            },
            child: const Text(
              'Next Question',
            ),
          ),
        ],
      ),
    );
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex += 1;
      selectedOption = -1;
      isSelected = false;
      isCorrect = false;
      currentQues =
          QuesGenerator.QuesGenerator1("multiplication", currentQuestionIndex);
    });
  }
}
