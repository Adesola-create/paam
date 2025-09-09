import 'package:flutter/material.dart';

class TrainingAppUI extends StatelessWidget {
  const TrainingAppUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80), // room for bottom nav
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
                          Text("Welcome back,",
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text("Caleb",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      Stack(
                        children: [
                          const Icon(Icons.notifications_none,
                              size: 28, color: Colors.grey),
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
                      image: NetworkImage(
                          "https://placehold.co/600x400/a79ab1/ffffff?text=Faith+Illustration"),
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
                              Colors.transparent
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text("Featured Article",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            const SizedBox(height: 8),
                            const Text("The Transformative Power of Prayer",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const SizedBox(height: 4),
                            const Text(
                              "Discover how daily prayer can bring peace and strength into your life.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  height: 1.4),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                              onPressed: () {},
                              child: const Text("Read Now",  style: TextStyle(
                                  color: Colors.white,),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Training Dashboard
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Your Training Dashboard",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      progressItem("Module 1: Foundations of Faith", 0.75,
                          Colors.green, Colors.blue),
                      const SizedBox(height: 12),
                      progressItem("Module 2: The Old Testament", 0.4,
                          Colors.yellow, Colors.orange),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("View All Modules"),
                      )
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
                    quickAction(Icons.book, "Modules"),
                    quickAction(Icons.people, "Meetings"),
                    quickAction(Icons.volunteer_activism, "Donate"),
                  ],
                ),

                // Prayer Focus
                sectionTitle("Today's Prayer Focus"),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.indigo]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.self_improvement,
                            color: Colors.white, size: 32),
                        title: Text("Strength & Guidance",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "For our community leaders and their families.",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white30),
                      Text(
                        "\"Ask and it will be given to you; seek and you will find...\" - Matthew 7:7",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white70),
                      )
                    ],
                  ),
                ),

                // Guidance Section
                sectionTitle("Spiritual Guidance"),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Have Questions?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            Text("Get AI-powered answers about faith.",
                                style: TextStyle(color: Colors.white70)),
                          ]),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                        child: const Text("Ask Now",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ),

                // TODO: Events, New Members, Spotlight, Verse — can be added the same way
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: "Training"),
          BottomNavigationBarItem(
              icon: Icon(Icons.church), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Giving"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
      ),
    );
  }

  // Helper for progress bars
  Widget progressItem(
      String title, double progress, Color startColor, Color endColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
          Text("${(progress * 100).toInt()}%",
              style: const TextStyle(fontSize: 12, color: Colors.grey))
        ]),
        const SizedBox(height: 6),
       ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: ShaderMask(
    shaderCallback: (Rect bounds) {
      return LinearGradient(
        colors: [startColor, endColor],
      ).createShader(bounds);
    },
    child: LinearProgressIndicator(
      value: progress,
      minHeight: 8,
      backgroundColor: Colors.grey[300],
      color: Colors.white, // required, but overridden by ShaderMask
    ),
  ),
)

      ],
    );
  }

  // Section title widget
  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  // Quick action tile
  Widget quickAction(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              child: Icon(icon, color: Colors.deepPurple)),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}