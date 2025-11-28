import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

// --- Data Models and Constants ---

class Question {
  final String key;
  final String title;
  final List<String> options;

  Question({required this.key, required this.title, required this.options});
}

final List<Question> diagnosticQuestions = [
  Question(
    key: 'q1',
    title: 'Where does the noise or vibration seem to come from?',
    options: ['Engine area', 'Wheels/tires', 'Chain/sprocket area', 'Brakes'],
  ),
  Question(
    key: 'q2',
    title: 'What kind of noise is it?',
    options: [
      'Knocking / pinging (like metal hitting metal)',
      'Ticking / tapping sound',
      'Grinding noise',
      'High-pitched whine'
    ],
  ),
  Question(
    key: 'q3',
    title: 'Does the ticking change with engine speed?',
    options: [
      'Yes, ticking gets faster when I rev the engine',
      'No, it stays about the same',
      'Not sure'
    ],
  ),
  Question(
    key: 'q4',
    title: 'Do you feel loss of power or rough idling with the ticking?',
    options: ['Yes', 'No'],
  ),
  Question(
    key: 'q5',
    title: 'Is the ticking louder when the engine is cold or when it’s fully warmed up?',
    options: ['Louder cold', 'Louder warm'],
  ),
  Question(
    key: 'q6',
    title: 'Is oil change overdue?',
    options: ['Yes', 'No'],
  ),
];

class DiagnosisTwoScreen extends ConsumerStatefulWidget {
  const DiagnosisTwoScreen({super.key});

  @override
  ConsumerState<DiagnosisTwoScreen> createState() => _DiagnosisTwoScreenState();
}

class _DiagnosisTwoScreenState extends ConsumerState<DiagnosisTwoScreen> {
  // Map to store selected option index for each question key
  final Map<String, int?> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    for (var q in diagnosticQuestions) {
      _selectedAnswers[q.key] = null;
    }
  }

  // --- Custom Widget for a Single Question Block ---
  Widget _buildQuestionBlock(Question question) {
    final int? selectedIndex = _selectedAnswers[question.key];
    final List<String> optionLetters = ['A', 'B', 'C', 'D'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        color: appCardColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Title
              Text(
                question.title,
                style: const TextStyle(
                  color: appMainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              // Options List
              ...List.generate(question.options.length, (index) {
                final String option = question.options[index];
                final String letter =
                optionLetters[index % optionLetters.length];
                final bool isSelected = selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAnswers[question.key] = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Letter Circle
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                            isSelected ? appButtonColor : appBackgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? appButtonColor
                                  : appTextColor.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            letter,
                            style: TextStyle(
                              color:
                              isSelected ? Colors.white : appMainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Option Text
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              color: appMainTextColor,
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // --- Custom Widget for Diagnosis Result ---
  Widget _buildDiagnosisResult() {
    return Card(
      color: appMainTextColor.withOpacity(0.1), // Adjusted for theme
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(top: 16.0, bottom: 24.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Probable Diagnosis:',
              style: TextStyle(
                color: appButtonColor, // Accent Red
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your bike likely has loose valve clearance (sometimes called tappet noise). This is a normal wear issue that happens when the gap between the valve and rocker arm gets bigger with time.',
              style: TextStyle(
                color: appMainTextColor,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          // --- Custom Header ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: appMainTextColor),
                  onPressed: () {
                    ref.read(goRouterProvider).pop();
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Diagnose',
                      style: TextStyle(
                        color: appMainTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance the back button
              ],
            ),
          ),

          // --- Scrollable Content ---
          Expanded(
            child: ListView(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                ...diagnosticQuestions.map((q) => _buildQuestionBlock(q)).toList(),
                _buildDiagnosisResult(),
              ],
            ),
          ),

          // --- Sticky Bottom Buttons ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: appBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Find a Mechanic Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Find Mechanic logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appCardColor,
                        foregroundColor: appButtonColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(color: appButtonColor, width: 2),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Find a Mechanic',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // Fix It Myself Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Fix It Myself logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appButtonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Fix It Myself',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}