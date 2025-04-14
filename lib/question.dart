import 'package:html/parser.dart' as htmlParser;

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    // Decode options by combining incorrect answers with the correct answer and shuffling them.
    String decodedQuestion = htmlParser.parse(json['question']).documentElement?.text ?? '';
    String decodedCorrectAnswer = htmlParser.parse(json['correct_answer']).documentElement?.text ?? '';
    List<String> options = List<String>.from(json['incorrect_answers']).map((option) {
      return htmlParser.parse(option).documentElement?.text ?? '';
    }).toList();
    options.add(decodedCorrectAnswer);
    options.shuffle();

    return Question(
      question: decodedQuestion,
      options: options,
      correctAnswer: decodedCorrectAnswer,
    );
  }
}
