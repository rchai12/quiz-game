import 'package:flutter/material.dart';
import 'quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _amountController = TextEditingController(text: '10');

  int? _selectedCategory;
  String? _selectedDifficulty;

  final Map<String, int> _categories = {
    'General Knowledge': 9,
    'Books': 10,
    'Film': 11,
    'Music': 12,
    'Science': 17,
    'Sports': 21,
    'History': 23,
  };

  final List<String> _difficulties = ['easy', 'medium', 'hard'];

  void _startQuiz() {
    final int amount = int.tryParse(_amountController.text) ?? 10;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          amount: amount,
          category: _selectedCategory,
          difficulty: _selectedDifficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia Quiz Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Number of Questions'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: _selectedCategory,
              items: _categories.entries
                  .map(
                    (entry) => DropdownMenuItem<int>(
                      value: entry.value,
                      child: Text(entry.key),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Difficulty'),
              value: _selectedDifficulty,
              items: _difficulties
                  .map(
                    (diff) => DropdownMenuItem<String>(
                      value: diff,
                      child: Text(diff[0].toUpperCase() + diff.substring(1)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDifficulty = value;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _startQuiz,
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
