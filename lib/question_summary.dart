import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Text(((data['question_index'] as int) + 1).toString()),
                Expanded(
                  child: Column(
                    children: [
                      Text(data['question'] as String,
                      style:const TextStyle(
                        color:Colors.white,
                        fontSize: 24,
                      ),
                      ),
                      const SizedBox(height: 5),
                      Text(data['user_answer'] as String,
                      style:const TextStyle(
                        color:Colors.white,
                        fontSize: 24,
                      ),),
                      Text(data['correct_answer'] as String,
                      style:const TextStyle(
                        color:Colors.white,
                        fontSize: 24,
                      ),),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
