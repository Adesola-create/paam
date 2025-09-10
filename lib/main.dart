import 'package:flutter/material.dart';
import 'slide_screen.dart';
import 'login.dart';
import 'sign_up.dart';
import 'dashboard.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAAM Digital Hub',
      // Start with Splash Screen
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/slides': (context) => SlideScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => DashboardScreen(),
      },
    );
  }
}
