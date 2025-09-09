import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'FocusOfTheDayScreen.dart';
import 'VerseOfTheDayScreen.dart';
import 'event.dart';
import 'give_screen.dart';
import 'profile.dart';
import 'settings.dart';
import 'notifications.dart';
import 'help.dart';
import 'badges.dart';
import 'training_records.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image
  Future<void> _pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  // Function to share app
  void _shareApp() {
    Share.share(
      'Check out PAAM Digital Hub! Download the app now.\nhttps://play.google.com/store/apps/details?id=com.paam.app',
      subject: 'PAAM Digital Hub',
    );
  }

  // Function to handle logout
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout functionality here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // ===== Profile =====
            ListTile(
              leading: GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 30)
                      : null,
                ),
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('View and edit your profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen(image: _profileImage)),
                );
              },
            ),

            const Divider(),

            // ===== New Items =====
            _buildListTile(
              icon: Icons.emoji_events,
              title: 'Badges',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BadgesScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.school,
              title: 'Training Records',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TrainingRecordsScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.event,
              title: 'Events',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EventScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.book,
              title: 'Verse of the Day',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VerseOfTheDayScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.lightbulb,
              title: 'Focus of the Day',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FocusOfTheDayScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.share,
              title: 'Share App',
              onTap: _shareApp,
            ),
            _buildListTile(
              icon: Icons.volunteer_activism,
              title: 'Giving',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => GiveScreen()),
                );
              },
            ),

            const Divider(),

            // ===== Existing Items =====
            _buildListTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NotificationsScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.help,
              title: 'Help',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HelpScreen()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.exit_to_app,
              title: 'Logout',
              iconColor: Colors.red,
              onTap: _logout,
            ),
          ],
        ),
      ),

      // ===== Bottom Navigation Bar =====
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Donation'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/training');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/community');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/donation');
          }
        },
      ),
    );
  }
}
