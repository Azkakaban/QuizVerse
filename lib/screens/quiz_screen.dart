import 'package:flutter/material.dart';

import '../data/quiz_questions.dart';
import '../widgets/answer_option.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const QuizScreen({
    super.key,
    required this.playerName,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;

  late List<int?> _selectedAnswers;

  @override
  void initState() {
    super.initState();

    _selectedAnswers = List<int?>.filled(
      quizQuestions.length,
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[_currentQuestionIndex];

    final selectedAnswerIndex =
        _selectedAnswers[_currentQuestionIndex];

    final isFirstQuestion = _currentQuestionIndex == 0;

    final isLastQuestion =
        _currentQuestionIndex == quizQuestions.length - 1;

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Quiz'),
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 700,
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${widget.playerName}!',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Soal ${_currentQuestionIndex + 1} dari '
                        '${quizQuestions.length}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      const SizedBox(height: 12),

                      LinearProgressIndicator(
                        value:
                            (_currentQuestionIndex + 1) /
                                quizQuestions.length,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        question.question,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      const SizedBox(height: 24),

                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: question.options.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12),
                            child: AnswerOption(
                              text: question.options[index],
                              isSelected:
                                  selectedAnswerIndex == index,
                              onTap: () {
                                setState(() {
                                  _selectedAnswers[
                                      _currentQuestionIndex] = index;
                                });
                              },
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: isFirstQuestion
                                  ? null
                                  : () {
                                      setState(() {
                                        _currentQuestionIndex--;
                                      });
                                    },
                              child: const Text('Previous'),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: FilledButton(
                              onPressed:
                                  selectedAnswerIndex == null
                                      ? null
                                      : () {
                                          if (!isLastQuestion) {
                                            setState(() {
                                              _currentQuestionIndex++;
                                            });
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ResultScreen(
                                                  playerName:
                                                      widget.playerName,
                                                  selectedAnswers:
                                                      _selectedAnswers,
                                                  onThemeToggle:
                                                      widget
                                                          .onThemeToggle,
                                                  isDarkMode:
                                                      isDark,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                              child: Text(
                                isLastQuestion
                                    ? 'Selesai'
                                    : 'Next',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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