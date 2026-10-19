import 'package:flutter/material.dart';

import '../data/quiz_questions.dart';

class ReviewScreen extends StatelessWidget {
  final List<int?> selectedAnswers;
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ReviewScreen({
    super.key,
    required this.selectedAnswers,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Jawaban'),
        actions: [
          IconButton(
            onPressed: onThemeToggle,
            tooltip: isDark ? 'Mode terang' : 'Mode gelap',
            icon: Icon(
              isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: quizQuestions.length,
          itemBuilder: (context, index) {
            final question = quizQuestions[index];
            final selectedAnswer =
                selectedAnswers[index];
            final correctAnswer =
                question.correctAnswerIndex;

            final isCorrect =
                selectedAnswer == correctAnswer;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Card(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Soal ${index + 1}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          question.question,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Jawaban kamu:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          selectedAnswer == null
                              ? 'Tidak dijawab'
                              : question
                                  .options[selectedAnswer],
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,
                            color: isCorrect
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Jawaban benar:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          question.options[
                              correctAnswer],
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Icon(
                              isCorrect
                                  ? Icons
                                      .check_circle_rounded
                                  : Icons
                                      .cancel_rounded,
                              color: isCorrect
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCorrect
                                  ? 'Benar'
                                  : 'Salah',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                color: isCorrect
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}