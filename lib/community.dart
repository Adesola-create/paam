import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CommunityTile(title: 'Prayer Requests', members: 123),
          CommunityTile(title: 'Bible Study Group', members: 456),
          CommunityTile(title: 'Youth Ministry', members: 789),
          CommunityTile(title: "Women’s Fellowship", members: 101),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Donation'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        currentIndex: 1, // Set the currently selected index
        onTap: (index) {
          // Handle navigation based on the tapped index if needed
          // Example: Navigator.push(context, ...)
        },
      ),
    );
  }
}

class CommunityTile extends StatelessWidget {
  final String title;
  final int members;

  CommunityTile({required this.title, required this.members});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text('$members members'),
      leading: CircleAvatar(
        child: Icon(Icons.people),
      ),
      onTap: () {
        // Add functionality for tapping on the community tile if needed
      },
    );
  }
}