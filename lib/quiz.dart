// quiz.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
//import 'lesson_list.dart';

class QuizScreen extends StatefulWidget {
  final int currentModuleIndex;
  final int totalModules;
  final int lessonIndex;

  const QuizScreen({
    Key? key,
    required this.currentModuleIndex,
    required this.totalModules,
    required this.lessonIndex,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> questions = [
    "What is the central theme of the Mosaic Law?",
    "The Mosaic Law was primarily concerned with rituals and sacrifices.",
  ];

  final List<List<String>> options = [
    ["A. The Covenant", "B. The Ten Commandments", "C. The Promised Land", "D. Observe the Sabbath"],
    ["True", "False"]
  ];

  // set correct answers appropriately (index positions)
  final List<int> correctAnswers = [1, 1]; // (for demo)

  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;

  void _onSelect(int? val) {
    setState(() {
      selectedAnswerIndex = val;
    });
  }

  void _submitOrNext() {
    if (selectedAnswerIndex == null) return;

    // tally score
    if (selectedAnswerIndex == correctAnswers[currentQuestionIndex]) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      });
      return;
    }

    // last question -> show result modal and let user choose next action
    final passed = score >= (questions.length / 2); // simple pass criteria
    _showResultModal(passed);
  }

  void _showResultModal(bool passed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final isLastLesson = widget.lessonIndex == 4; // if each module has 5 lessons (match LessonList)
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(passed ? Icons.emoji_events : Icons.error_outline, size: 72, color: passed ? Colors.green : Colors.red),
              const SizedBox(height: 12),
              Text(passed ? "Congratulations!" : "Try Again", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                passed ? "You passed the quiz (${score}/${questions.length})." : "You scored ${score}/${questions.length}. Review the lesson and try again.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48), backgroundColor: passed ? Colors.green : Colors.red),
                  onPressed: () {
                    Navigator.pop(ctx); // close dialog
                    // pop QuizScreen returning pass/fail result to the caller (LessonScreen)
                    Navigator.pop(context, passed);
                  },
                  child: Text(passed ? (isLastLesson ? "Finish Module" : "Proceed") : "Back to Lesson", style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              if (!passed)
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx); // close modal
                    // reset quiz to let user try again
                    setState(() {
                      currentQuestionIndex = 0;
                      selectedAnswerIndex = null;
                      score = 0;
                    });
                  },
                  child: Text("Retry Quiz", style: GoogleFonts.poppins(color: primaryColor)),
                ),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final opts = options[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz — Lesson ${widget.lessonIndex + 1}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LinearProgressIndicator(value: (currentQuestionIndex + 1) / questions.length, minHeight: 8, backgroundColor: Colors.grey[300], color: primaryColor),
          const SizedBox(height: 16),
          Text("Question ${currentQuestionIndex + 1} of ${questions.length}", style: GoogleFonts.poppins(color: Colors.grey[700])),
          const SizedBox(height: 8),
          Text(question, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...List.generate(opts.length, (i) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(bottom: 8),
              child: RadioListTile<int>(
                title: Text(opts[i], style: GoogleFonts.poppins()),
                value: i,
                groupValue: selectedAnswerIndex,
                onChanged: _onSelect,
                activeColor: primaryColor,
              ),
            );
          }),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedAnswerIndex == null ? null : _submitOrNext,
              style: primaryButtonStyle,
              child: Text(currentQuestionIndex == questions.length - 1 ? "Submit" : "Next", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }
}
