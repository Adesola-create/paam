import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'lesson_list.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final int totalModules = 5;
  int unlockedModules = 1;

  String? selectedTraining; // ✅ to track which training is chosen

  void _showLeadershipModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium, color: Colors.purple, size: 80),
                const SizedBox(height: 15),
                Text(
                  "🎉 All Modules Completed!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "You've successfully completed all training modules. You're now eligible for Leadership Training.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: 1.0,
                  minHeight: 12,
                  backgroundColor: Colors.grey[300],
                  color: Colors.purple,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Navigate to leadership training screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Move to incubation stage",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openModule(int index) async {
    final completed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonList(
          currentModuleIndex: index,
          totalModules: totalModules,
        ),
      ),
    );

    if (completed == true) {
      if (index + 1 <= totalModules && unlockedModules < totalModules) {
        setState(() => unlockedModules = index + 2);
      } else if (index + 1 == totalModules) {
        _showLeadershipModal();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = unlockedModules / totalModules;

    return Scaffold(
      appBar: AppBar(),
      body: selectedTraining == null
          // ✅ Step 1: Training type selection
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mandate\nTraining",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Grow in faith and leadership through our comprehensive training modules. Choose your path and begin your spiritual journey today.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Select the type of training to begin:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.school, color: Colors.pink),
                      title: const Text("Faith Training"),
                      subtitle: const Text("Foundational spiritual growth modules"),
                      onTap: () {
                        setState(() {
                          selectedTraining = "faith";
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.leaderboard, color: Colors.purple),
                      title: const Text("Leadership Training"),
                      subtitle: const Text("Advanced leadership and mentoring modules"),
                      onTap: () {
                        setState(() {
                          selectedTraining = "leadership";
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          // ✅ Step 2: Show original training details after selection
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== Heading ======
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedTraining == "faith" ? "Faith" : "Leadership"}\nTraining",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Welcome to the ${selectedTraining == "faith" ? "Faith" : "Leadership"} Training Program! "
                        "Here you'll gain spiritual insights and practical steps to strengthen your faith and leadership journey. "
                        "Complete each module to unlock the next.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                // ====== Training Progress Bar ======
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Training Progress",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            "${(progress * 100).toStringAsFixed(0)}%",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ====== Modules Heading ======
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Modules",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                // ====== Module List ======
                Expanded(
                  child: ListView.builder(
                    itemCount: totalModules,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final isUnlocked = index < unlockedModules;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isUnlocked ? Colors.pink : Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          title: Text(
                            "Module ${index + 1}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isUnlocked ? Colors.black : Colors.grey,
                            ),
                          ),
                          subtitle: Text(
                            isUnlocked
                                ? "Tap to start this module"
                                : "Locked until previous module is completed",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: isUnlocked ? Colors.black54 : Colors.grey,
                            ),
                          ),
                          trailing: Icon(
                            isUnlocked ? Icons.play_circle_fill : Icons.lock,
                            color: isUnlocked ? Colors.pink : Colors.grey,
                            size: 24,
                          ),
                          onTap: isUnlocked ? () => _openModule(index) : null,
                        ),
                      );
                    },
                  ),
                ),

                // ====== Continue Button ======
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: unlockedModules < totalModules
                        ? () => _openModule(unlockedModules)
                        : _showLeadershipModal,
                    style: shortButtonStyle1,
                    child: Text(
                      unlockedModules < totalModules
                          ? "Continue"
                          : "Complete Training",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
