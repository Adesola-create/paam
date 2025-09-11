import 'package:flutter/material.dart';
import 'constants.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications &\nUpdates",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Stay updated with the latest announcements, prayer requests, and community activities.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildNotificationTile(
                    "New Training Module Available",
                    "Module 3: Walking in Faith is now unlocked",
                    Icons.school,
                    "2 hours ago",
                  ),
                  _buildNotificationTile(
                    "Prayer Request Update",
                    "Thank you for your prayers. Sarah's surgery was successful!",
                    Icons.favorite,
                    "1 day ago",
                  ),
                  _buildNotificationTile(
                    "Community Meeting Reminder",
                    "Don't forget about tomorrow's Bible study at 7 PM",
                    Icons.people,
                    "2 days ago",
                  ),
                  _buildNotificationTile(
                    "Donation Campaign",
                    "Water for All campaign has reached 75% of its goal",
                    Icons.volunteer_activism,
                    "3 days ago",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile(String title, String subtitle, IconData icon, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.1),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle, style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}