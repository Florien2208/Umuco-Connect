import 'package:flutter/material.dart';
import './signup_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 1;
  final int totalQuestions = 3;
  String? selectedLanguage;
  String? selectedStudyTime;
  String? selectedInformationSource;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (currentQuestionIndex < totalQuestions) {
      _controller.reset();
      setState(() {
        currentQuestionIndex++;
      });
      _controller.forward();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  Widget _buildQuestion() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          _getQuestionTitle(),
          style: theme.textTheme.headlineMedium?.copyWith(
            color: isDark ? Colors.white : Colors.deepOrange[700],
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          _getQuestionSubtitle(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.grey[300] : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getQuestionTitle() {
    switch (currentQuestionIndex) {
      case 1:
        return 'Choose Your Learning Language';
      case 2:
        return 'Daily Study Commitment';
      case 3:
        return 'Your Learning Resources';
      default:
        return '';
    }
  }

  String _getQuestionSubtitle() {
    switch (currentQuestionIndex) {
      case 1:
        return 'Select the language you want to learn';
      case 2:
        return 'How much time can you dedicate to learning?';
      case 3:
        return 'Where do you usually get your learning materials?';
      default:
        return '';
    }
  }

  Widget _buildOption(
      String text, String value, void Function(String?) onSelected) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    bool isSelected = _getCurrentSelectedValue() == value;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: () {
          onSelected(value);
          _handleContinue();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                    ? Colors.deepOrange.withOpacity(0.2)
                    : Colors.deepOrange[100])
                : (isDark ? Colors.grey[800] : Colors.grey[200]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.transparent,
              width: 2,
            ),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: isSelected
                        ? (isDark ? Colors.deepOrange : Colors.deepOrange[800])
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: isDark ? Colors.deepOrange : Colors.deepOrange[700],
                  size: 28,
                )
            ],
          ),
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
          _buildOption('English', 'English',
              (value) => setState(() => selectedLanguage = value)),
          _buildOption('Spanish', 'Spanish',
              (value) => setState(() => selectedLanguage = value)),
          _buildOption('French', 'French',
              (value) => setState(() => selectedLanguage = value)),
        ];
      case 2:
        return [
          _buildOption('Less than 30 minutes', 'less_30',
              (value) => setState(() => selectedStudyTime = value)),
          _buildOption('30-60 minutes', 'between_30_60',
              (value) => setState(() => selectedStudyTime = value)),
          _buildOption('More than 60 minutes', 'more_60',
              (value) => setState(() => selectedStudyTime = value)),
        ];
      case 3:
        return [
          _buildOption('Books', 'books',
              (value) => setState(() => selectedInformationSource = value)),
          _buildOption('Online Blogs', 'blogs',
              (value) => setState(() => selectedInformationSource = value)),
          _buildOption('Videos', 'videos',
              (value) => setState(() => selectedInformationSource = value)),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    double progress = currentQuestionIndex / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Indicator
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question $currentQuestionIndex of $totalQuestions',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                          isDark ? Colors.grey[800] : Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark ? Colors.deepOrange : const Color(0xFFE67E22),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            // Question Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Center(child: _buildQuestion()),
            ),
            // Answer Options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: _buildOptions(),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
