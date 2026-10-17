import 'package:flutter/material.dart';

import '../data/quiz_questions.dart';

class ResultScreen extends StatelessWidget {
  final String playerName;
  final List<int?> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.playerName,
    required this.selectedAnswers,
  });

  int _calculateScore() {
    int score = 0;

    for (int i = 0; i < quizQuestions.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i].correctAnswerIndex) {
        score++;
      }
    }

    return score;
  }

  @override
  Widget build(BuildContext context) {
    final score = _calculateScore();
    final totalQuestions = quizQuestions.length;
    final percentage = (score / totalQuestions * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Quiz'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    size: 90,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Quiz Selesai!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Bagus, $playerName!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 32),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Text(
                            '$score / $totalQuestions',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Jawaban benar',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge,
                          ),

                          const SizedBox(height: 16),

                          Text(
                            '$percentage%',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text('Kembali ke Beranda'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}