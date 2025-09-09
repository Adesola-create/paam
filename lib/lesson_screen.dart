// lesson_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'quiz.dart';

class LessonScreen extends StatefulWidget {
  final int lessonIndex;
  final int currentModuleIndex;
  final int totalModules;

  const LessonScreen({
    Key? key,
    required this.lessonIndex,
    required this.currentModuleIndex,
    required this.totalModules,
  }) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {

  Future<void> _takeQuiz() async {
    // Navigate to quiz and wait for pass/fail result
    final passed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          currentModuleIndex: widget.currentModuleIndex,
          totalModules: widget.totalModules,
          lessonIndex: widget.lessonIndex,
        ),
      ),
    );

    if (passed == true) {
      // Pop back to LessonList, marking this lesson as completed
      Navigator.pop(context, true);
    } else if (passed == false) {
      // Quiz failed — remain here, allow retry
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Quiz not passed. Please review the lesson and try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson ${widget.lessonIndex + 1}",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Module ${widget.currentModuleIndex + 1}",
              style: GoogleFonts.poppins(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              "Lesson ${widget.lessonIndex + 1}: Title",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Long lesson content goes here. Keep your sections and subheadings here as needed. "
                  "This content is scrollable. After reviewing, tap 'Take Quiz' at the bottom to attempt the lesson quiz.",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: primaryButtonStyle,
                onPressed: _takeQuiz,
                child: Text(
                  "Take Quiz",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              style: secondaryButtonStyle,
              child: Text(
                "Go Back",
                style: GoogleFonts.poppins(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
