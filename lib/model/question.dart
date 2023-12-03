class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "22+45",
    "options": ['56', '23', '12', '109'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "56*78",
    "options": ['2017', '2717', '2907', '2018'],
    "answer_index": 2,
  },
];
