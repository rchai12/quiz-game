import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions({
    int amount = 10,
    int? category,
    String? difficulty,
  }) async {
    final queryParameters = {
      'amount': amount.toString(),
      if (category != null) 'category': category.toString(),
      if (difficulty != null && ['easy', 'medium', 'hard'].contains(difficulty.toLowerCase()))
        'difficulty': difficulty.toLowerCase(),
      'type': 'multiple',
    };

    final uri = Uri.https('opentdb.com', '/api.php', queryParameters);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['response_code'] != 0) {
          throw Exception('Invalid response code: ${data['response_code']}');
        }

        return (data['results'] as List)
            .map((questionData) => Question.fromJson(questionData))
            .toList();
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
