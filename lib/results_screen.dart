import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';


class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final VoidCallback onRestart;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();

    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where(
      (data) {
        return data['correct_answer'] == data['user_answer'];
      },
    ).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: summaryData.length,
                itemBuilder: (ctx, index) {
                  final questionData = summaryData[index];
                  final isCorrect = questionData['correct_answer'] ==
                      questionData['user_answer'];
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Large Number with Color Coding
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              isCorrect ? Colors.green : Colors.red,
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Question and Answers
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                questionData['question'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // User Answer
                              Text(
                                'Your answer: ${questionData['user_answer']}',
                                style: TextStyle(
                                  color: isCorrect
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  fontSize: 16,
                                ),
                              ),
                              // Correct Answer
                              if (!isCorrect)
                                Text(
                                  'Correct answer: ${questionData['correct_answer']}',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Restart Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

