import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'Training.dart';
import 'community.dart';
import 'donation.dart';
import 'home.dart';
import 'more.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // Start with the Training screen

  final List<Widget> _screens = [
    HomeScreen(), // Replace with your actual screen
    TrainingPage(),
    CommunityScreen(),
    DonationScreen(),
    MoreScreen(),


    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mandate Training"),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Training',
          ),
          // Add more items as needed
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFB0003A),
      ),
    );
  }
}