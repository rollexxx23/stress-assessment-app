import 'dart:math';

import 'package:frontend/model/question.dart';

class QuesGenerator {
  // add ap and gp series
  static QuesGenerator1(String type, int id) {
    var rng = Random();
    if (type == "multiplication") {
      int val1 = rng.nextInt(100);
      int val2 = rng.nextInt(100);
      int correct = rng.nextInt(4);

      List<String> options = ["", "", "", ""];
      for (int i = 0; i < 4; i++) {
        if (correct == i) {
          options[i] = (val1 * val2).toString();
        } else {
          options[i] = (rng.nextInt(1001)).toString();
        }
      }
      return Question(
          id: id, question: "$val1*$val2?", answer: correct, options: options);
    } else if (type == "addition") {
      int val1 = rng.nextInt(100);
      int val2 = rng.nextInt(100);
      int correct = rng.nextInt(4);

      List<String> options = ["", "", "", ""];
      for (int i = 0; i < 4; i++) {
        if (correct == i) {
          options[i] = (val1 + val2).toString();
        } else {
          options[i] = (rng.nextInt(201)).toString();
        }
      }
      return Question(
          id: id, question: "$val1+$val2?", answer: correct, options: options);
    }
  }
}
