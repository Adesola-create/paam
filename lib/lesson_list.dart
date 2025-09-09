// lesson_list.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'lesson_screen.dart';
import '../constants.dart';

class LessonList extends StatefulWidget {
  final int currentModuleIndex;
  final int totalModules;

  const LessonList({
    Key? key,
    required this.currentModuleIndex,
    required this.totalModules,
  }) : super(key: key);

  @override
  _LessonListState createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  final List<String> lessons = [
    "Lesson 1: The Burning Bush",
    "Lesson 2: Pharaoh's Resistance",
    "Lesson 3: The Ten Plagues",
    "Lesson 4: The Exodus",
    "Lesson 5: Crossing the Red Sea",
  ];

  // track how many lessons passed (unlocked)
  int completedLessons = 0;

  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/intro_video.mp4")
      ..initialize().then((_) {
        setState(() => _isVideoInitialized = true);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  // Called when a lesson is passed in this module
  void _onLessonPassed() {
    setState(() {
      if (completedLessons < lessons.length) completedLessons++;
    });
    // if all lessons passed -> return true to caller (module completed)
    if (completedLessons >= lessons.length) {
      // pop and indicate module completed
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = completedLessons / lessons.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context, false)),
        title: Text("Module ${widget.currentModuleIndex + 1} Lessons", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Module ${widget.currentModuleIndex + 1}: The Call of Moses", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // Video
          _isVideoInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: Stack(alignment: Alignment.center, children: [
                    VideoPlayer(_videoController),
                    IconButton(
                      icon: Icon(_videoController.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 50, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      },
                    ),
                  ]),
                )
              : Container(height: 200, color: Colors.black12, child: const Center(child: CircularProgressIndicator())),
          const SizedBox(height: 12),

          Text(
            "In this module, we explore the divine calling of Moses and the leadership journey that followed.",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.6),
          ),
          const SizedBox(height: 20),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Lessons Completed", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
            Text("$completedLessons/${lessons.length}", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 12),

          // Gradient progress visual (uses ShaderMask)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(colors: [primaryColor, const Color(0xFFB0003A)]).createShader(bounds),
              child: LinearProgressIndicator(value: progress, minHeight: 8, backgroundColor: Colors.grey[300], valueColor: AlwaysStoppedAnimation(Colors.white)),
            ),
          ),
          const SizedBox(height: 20),

          // Lessons list
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lessons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final isUnlocked = index <= completedLessons;
              final isDone = index < completedLessons;
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(lessons[index], style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  subtitle: Text(isDone ? "Completed" : (isUnlocked ? "Unlocked" : "Locked"), style: GoogleFonts.poppins(color: isUnlocked ? Colors.grey[700] : Colors.grey)),
                  trailing: isDone
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : isUnlocked
                          ? Icon(Icons.play_circle_fill, color: const Color(0xFFB0003A))
                          : Icon(Icons.lock, color: Colors.grey),
                  onTap: isUnlocked
                      ? () async {
                          // navigate to lesson screen and await whether the lesson was passed (true)
                          final passed = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LessonScreen(
                                lessonIndex: index,
                                currentModuleIndex: widget.currentModuleIndex,
                                totalModules: widget.totalModules,
                              ),
                            ),
                          );

                          // If child returned true -> lesson passed: unlock next lesson
                          if (passed == true) {
                            _onLessonPassed();
                          }
                        }
                      : null,
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
