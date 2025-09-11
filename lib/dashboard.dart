import 'package:flutter/material.dart';
import 'Training.dart';
import 'community.dart';
import 'give_screen.dart';
import 'more.dart';
import 'constants.dart';
import 'notifications.dart';
import 'article_screen.dart';
import 'ai_guidance_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // List of pages for bottom navigation
  final List<Widget> _pages = [
     DashboardHome(),    // Home dashboard UI
     TrainingPage(),   // Training screen
     CommunityScreen(),  // Community screen
     GiveScreen(),     // Giving screen
     MoreScreen(),       // More options screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Training"),
          BottomNavigationBarItem(icon: Icon(Icons.church), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Giving"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
      ),
    );
  }
}

// ---------------------- HOME SCREEN ----------------------
class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Welcome back, Caleb ", style: TextStyle(fontSize: 20, color: Colors.black)),
                        //Text("Caleb", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
                      },
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications_none, size: 28, color: Colors.grey),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Hero Card
              Container(
  margin: const EdgeInsets.all(16),
  height: 240,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    image: const DecorationImage(
      image: AssetImage("assets/slide1.png"),
      fit: BoxFit.cover,
    ),
  ),
  child: Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Featured Article",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "The Transformative Power of Prayer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Discover how daily prayer can bring peace and strength into your life.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleScreen()));
              },
              child: const Text(
                "Read Now",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ],
  ),
),

              // Training Dashboard
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Your Training Progress",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    progressItem("Overall Training Progress", 0.65),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage()));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: primaryColor),
                      ),
                      child: Text("View All Modules", style: TextStyle(color: primaryColor)),
                    ),
                  ],
                ),
              ),

              // Quick Actions
              sectionTitle("Quick Actions"),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: [
                  quickAction(context, Icons.book, "Modules", () => Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage()))),
                  quickAction(context, Icons.people, "Meetings", () => Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityScreen()))),
                  quickAction(context, Icons.volunteer_activism, "Donate", () => Navigator.push(context, MaterialPageRoute(builder: (context) => GiveScreen()))),
                ],
              ),

              // Prayer Focus
              sectionTitle("Today's Prayer Focus"),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.self_improvement, color: Colors.white, size: 32),
                      title: Text("Strength & Guidance",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("For our community leaders and their families.",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    Divider(color: Colors.white30),
                    Text(
                      "\"Ask and it will be given to you; seek and you will find...\" - Matthew 7:7",
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              // Guidance Section
              sectionTitle("Spiritual Guidance"),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                      Text("Have Questions?",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("Get AI-powered answers about faith.", style: TextStyle(color: Colors.white70)),
                    ]),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AIGuidanceScreen()));
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white30),
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                      child: const Text("Ask Now", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progressItem(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          Text("${(progress * 100).toInt()}%",
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget quickAction(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: primaryColor.withOpacity(0.1), child: Icon(icon, color: primaryColor)),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}




