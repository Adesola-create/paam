import 'package:flutter/material.dart';
import 'home.dart'; 
import 'package:paam/constants.dart';

class CodeVerificationScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png', // Load your logo
              width: 100, // Adjust the size as needed
              height: 100,
            ),
            SizedBox(height: 20),
            // Verification Code Prompt
            Text(
              'Enter the code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We sent a verification code to your email. Please enter it below to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Code Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCodeInput(),
                SizedBox(width: 10),
                _buildCodeInput(),
                SizedBox(width: 10),
                _buildCodeInput(),
                SizedBox(width: 10),
                _buildCodeInput(),
              ],
            ),
            SizedBox(height: 20),
            // Resend Code Link
            TextButton(
              onPressed: () {
                // Handle resend code action
              },
              child: Text('Didn\'t receive the code? Resend'),
            ),
            SizedBox(height: 20),
            // Verify Button
            ElevatedButton(
              onPressed: () {
                // Handle verification action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Button color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInput() {
    return Container(
      width: 50,
      child: TextField(
        controller: _codeController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '0',
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    );
  }
}