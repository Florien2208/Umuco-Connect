import 'package:flutter/material.dart';
import './signup_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 1;
  final int totalQuestions = 3;
  String? selectedLanguage;
  String? selectedStudyTime;
  String? selectedInformationSource;

  void _handleContinue() {
    if (currentQuestionIndex < totalQuestions) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Navigate to signup screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  Widget _buildQuestion() {
    switch (currentQuestionIndex) {
      case 1:
        return Column(
          children: [
            Text(
              'Choose Your Learning Language',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Select the language you want to learn',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Text(
              'Daily Study Commitment',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'How much time can you dedicate to learning?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            Text(
              'Your Learning Resources',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Where do you usually get your learning materials?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOption(
      String text, String value, void Function(String?) onSelected) {
    bool isSelected = _getCurrentSelectedValue() == value;
    return GestureDetector(
      onTap: () {
        onSelected(value);
        _handleContinue();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? Colors.deepOrange[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? Colors.deepOrange : Colors.transparent,
                width: 2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ]),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.deepOrange[800] : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal)),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.deepOrange[700])
          ],
        ),
      ),
    );
  }

  String? _getCurrentSelectedValue() {
    switch (currentQuestionIndex) {
      case 1:
        return selectedLanguage;
      case 2:
        return selectedStudyTime;
      case 3:
        return selectedInformationSource;
      default:
        return null;
    }
  }

  List<Widget> _buildOptions() {
    switch (currentQuestionIndex) {
      case 1:
        return [
          _buildOption(
              'English',
              'English',
              (value) => setState(() {
                    selectedLanguage = value;
                  })),
          _buildOption(
              'Spanish',
              'Spanish',
              (value) => setState(() {
                    selectedLanguage = value;
                  })),
          _buildOption(
              'French',
              'French',
              (value) => setState(() {
                    selectedLanguage = value;
                  })),
        ];
      case 2:
        return [
          _buildOption(
              'Less than 30 minutes',
              'less_30',
              (value) => setState(() {
                    selectedStudyTime = value;
                  })),
          _buildOption(
              '30-60 minutes',
              'between_30_60',
              (value) => setState(() {
                    selectedStudyTime = value;
                  })),
          _buildOption(
              'More than 60 minutes',
              'more_60',
              (value) => setState(() {
                    selectedStudyTime = value;
                  })),
        ];
      case 3:
        return [
          _buildOption(
              'Books',
              'books',
              (value) => setState(() {
                    selectedInformationSource = value;
                  })),
          _buildOption(
              'Online Blogs',
              'blogs',
              (value) => setState(() {
                    selectedInformationSource = value;
                  })),
          _buildOption(
              'Videos',
              'videos',
              (value) => setState(() {
                    selectedInformationSource = value;
                  })),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentQuestionIndex / totalQuestions;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFE67E22)),
                        minHeight: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Question Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Center(child: _buildQuestion()),
            ),
            // Answer Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: _buildOptions(),
              ),
            ),
            const SizedBox(height: 30), // Bottom padding
          ],
        ),
      ),
    );
  }
}
